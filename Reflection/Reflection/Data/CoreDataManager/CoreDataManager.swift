import SwiftUI
import Combine
import CoreData

// MARK: - Managable
protocol ColorChipManagable {
    func insertColorChip(_ colorChip: ColorChip) -> AnyPublisher<ColorChipEntity, CoreDataManager.CoreDataError>
    func fetchAllColorChip() -> AnyPublisher<[ColorChipEntity], CoreDataManager.CoreDataError>
    func fetchSpecificColorChip(_ colorChip: ColorChip) -> AnyPublisher<ColorChipEntity, CoreDataManager.CoreDataError>
    func updateColorChip(_ colorChip: ColorChip) -> AnyPublisher<ColorChipEntity, CoreDataManager.CoreDataError>
    func deleteColorChip(id: UUID) -> AnyPublisher<[ColorChipEntity], CoreDataManager.CoreDataError>
}

protocol MemoryManagable {
    func insertMemory(_ memory: Memory) -> AnyPublisher<MemoryEntity, CoreDataManager.CoreDataError>
    func fetchAllMemory() -> AnyPublisher<[MemoryEntity], CoreDataManager.CoreDataError>
    func updateMemory(_ memory: Memory) -> AnyPublisher<MemoryEntity, CoreDataManager.CoreDataError>
    func deleteMemory(id: UUID) -> AnyPublisher<[MemoryEntity], CoreDataManager.CoreDataError>
}

// MARK: - CoreDataManager
final class CoreDataManager {
    
    enum CoreDataError: LocalizedError {
        case create
        case read
        case update
        case delete
        
        var errorDescription: String? {
            switch self {
            case .create: "Failed to Create Data"
            case .read: "Faile to Read Data"
            case .update: "Failed to Update Data"
            case .delete: "Failed to Delete Data"
            }
        }
    }
    
    static let shared = CoreDataManager()

    private init(inMemory: Bool = false) {
        if inMemory {
            self.persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ColorChipModel", managedObjectModel: CoreDataManager.createColorChip())
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy //객체 버전 우선
        return context
    }()
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        let context = self.persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy //객체 버전 우선
        return context
    }()
    
    /// fetch
    private func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    /// Memory -> MemoryEntity
    private func fetchMemoryEntity(of memory: [Memory]) -> [MemoryEntity] {
        let request = MemoryEntity.fetchRequest()
        request.predicate = NSPredicate(format: "identifier IN %@", memory.map{$0.id})
        guard let fetchResult = try? self.backgroundContext.fetch(request) else { return [] }
        return fetchResult
    }
}

extension CoreDataManager: ColorChipManagable {
    
    func insertColorChip(_ colorchip: ColorChip) -> AnyPublisher<ColorChipEntity, CoreDataError> {
        return Future { promise in
            self.backgroundContext.perform {
                let colorChipEntity = ColorChipEntity(context: self.backgroundContext, colorChip: colorchip)
                colorChipEntity.addToMemories(NSSet(array: self.fetchMemoryEntity(of: colorchip.memories)))
                
                do {
                    try self.backgroundContext.save()
                    promise(.success(colorChipEntity))
                } catch let error {
                    print(error)
                    promise(.failure(.create))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchAllColorChip() -> AnyPublisher<[ColorChipEntity], CoreDataError> {
        return Future { promise in
            self.backgroundContext.perform {
                do {
                    let request = ColorChipEntity.fetchRequest()
                    let fetchResult = try self.backgroundContext.fetch(request)
                    promise(.success(fetchResult))
                } catch {
                    promise(.failure(.read))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchSpecificColorChip(_ colorChip: ColorChip) -> AnyPublisher<ColorChipEntity, CoreDataManager.CoreDataError> {
        return Future { promise in
            self.backgroundContext.perform {
                do {
                    let request = ColorChipEntity.fetchRequest()
                    request.predicate = NSPredicate(
                        format: "%K == %@",
                        #keyPath(ColorChipEntity.identifier),
                        colorChip.id as CVarArg
                    )
                    let fetchResult = try self.backgroundContext.fetch(request)
                    guard let colorChipEntity = fetchResult.first else {
                        promise(.failure(.update))
                        return
                    }
                    Log.e(fetchResult)
                    
                    promise(.success(colorChipEntity))
                } catch {
                    promise(.failure(.update))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    
    func updateColorChip(_ colorChip: ColorChip) -> AnyPublisher<ColorChipEntity, CoreDataError> {
        return Future { promise in
            self.backgroundContext.perform {
                do {
                    let request = ColorChipEntity.fetchRequest()
                    request.predicate = NSPredicate(
                        format: "%K == %@",
                        #keyPath(ColorChipEntity.identifier),
                        colorChip.id as CVarArg
                    )
                    let fetchResult = try self.backgroundContext.fetch(request)
                    guard let colorChipEntity = fetchResult.first else {
                        promise(.failure(.update))
                        return
                    }
                    
                    colorChipEntity.colorName = colorChip.colorName
                    colorChipEntity.colorList = colorChip.colorList
                
                    colorChipEntity.addToMemories(NSSet(array:self.fetchMemoryEntity(of: colorChip.memories)))
                    
                    try self.backgroundContext.save()
                    promise(.success(colorChipEntity))
                } catch {
                    promise(.failure(.update))
                }
            }
        }.eraseToAnyPublisher()
    }
 
    func deleteColorChip(id: UUID) -> AnyPublisher<[ColorChipEntity], CoreDataError> {
        return Future { promise in
            self.backgroundContext.perform {
                do {
                    let request = ColorChipEntity.fetchRequest()
                    // %K: 키 경로, %@: 값
                    request.predicate = NSPredicate(
                        format: "%K == %@",
                        #keyPath(ColorChipEntity.identifier),
                        id as CVarArg
                    )
                    let fetchResult = try self.backgroundContext.fetch(request)
                    guard let colorChipEntity = fetchResult.first else {
                        promise(.failure(.delete))
                        return
                    }
                    self.backgroundContext.delete(colorChipEntity)
                    try self.backgroundContext.save()
                    
                    let deletedResult = try self.backgroundContext.fetch(ColorChipEntity.fetchRequest())
                    promise(.success((deletedResult)))
                } catch {
                    promise(.failure(.delete))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension CoreDataManager: MemoryManagable {

    func insertMemory(_ memory: Memory) -> AnyPublisher<MemoryEntity, CoreDataError> {
        return Future { promise in
            self.backgroundContext.perform {
                let memoryEntity = MemoryEntity(context: self.backgroundContext, memory: memory)
                do {
                    try self.backgroundContext.save()
                    promise(.success(memoryEntity))
                } catch let error {
                    print(error)
                    promise(.failure(.create))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchAllMemory() -> AnyPublisher<[MemoryEntity], CoreDataError> {
        return Future { promise in
            self.backgroundContext.perform {
                do {
                    let request = MemoryEntity.fetchRequest()
                    let fetchResult = try self.backgroundContext.fetch(request)
                    promise(.success(fetchResult))
                } catch {
                    promise(.failure(.read))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func updateMemory(_ memory: Memory) -> AnyPublisher<MemoryEntity, CoreDataError> {
        Future { promise in
           self.backgroundContext.perform {
               do {
                   let request = MemoryEntity.fetchRequest()
                   request.predicate = NSPredicate(
                       format: "%K == %@",
                       #keyPath(MemoryEntity.identifier),
                       memory.id as CVarArg
                   )
                   let fetchResult = try self.backgroundContext.fetch(request)
                   guard let memoryEntity = fetchResult.first else {
                       promise(.failure(.update))
                       return
                   }
                   
                   memoryEntity.picture = memory.picture
                   memoryEntity.title = memory.title
                   memoryEntity.date = memory.date
                   memoryEntity.reflection = memory.reflection
                
                   try self.backgroundContext.save()
                   promise(.success(memoryEntity))
               } catch {
                   promise(.failure(.update))
               }
           }
       }.eraseToAnyPublisher()
    }
    
    
    func deleteMemory(id: UUID) -> AnyPublisher<[MemoryEntity], CoreDataManager.CoreDataError> {
        return Future { promise in
            self.backgroundContext.perform {
                do {
                    let request = MemoryEntity.fetchRequest()
                    // %K: 키 경로, %@: 값
                    request.predicate = NSPredicate(
                        format: "%K == %@",
                        #keyPath(MemoryEntity.identifier),
                        id as CVarArg
                    )
                    let fetchResult = try self.backgroundContext.fetch(request)
                    
                    guard let memoryEntity = fetchResult.first else {
                        promise(.failure(.delete))
                        return
                    }
                    self.backgroundContext.delete(memoryEntity)
                    try self.backgroundContext.save()
                    
                    let deletedResult = try self.backgroundContext.fetch(MemoryEntity.fetchRequest())
                    promise(.success((deletedResult)))
                } catch {
                    promise(.failure(.delete))
                }
            }
        }.eraseToAnyPublisher()
    }
}
