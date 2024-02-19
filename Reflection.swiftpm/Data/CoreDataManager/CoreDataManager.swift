import SwiftUI
import Combine
import CoreData

// MARK: - Managable
protocol ColorChipManagable {
    func insertColorChip(_ colorChip: ColorChip) -> AnyPublisher<ColorChipEntity, CoreDataManager.CoreDataError>
    func fetchAllColorChip() -> AnyPublisher<[ColorChipEntity], CoreDataManager.CoreDataError>
//    func updateColorChip(_ colorChip: ColorChipEntity) -> AnyPublisher<ColorChipEntity, CoreDataManager.CoreDataError>
//    func deleteColorChip(id: UUID) -> AnyPublisher<Void, CoreDataManager.CoreDataError>
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
   
//        // 플레이그라운드 마이그레이션 오류 해결
//        let option = NSPersistentStoreDescription()
//        option.setOption(true as NSNumber, forKey: NSMigratePersistentStoresAutomaticallyOption)
//        option.setOption(true as NSNumber, forKey: NSInferMappingModelAutomaticallyOption)
//        container.persistentStoreDescriptions = [option]

        
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
    
    private func fetchMemoryEntity(of memory: [Memory]) -> [MemoryEntity] {
        let request = MemoryEntity.fetchRequest()
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
//    
//    func updateColorChip(_ colorChip: ColorChipEntity) -> AnyPublisher<ColorChipEntity, CoreDataError> {
//        <#code#>
//    }
//    
//    func deleteColorChip(id: UUID) -> AnyPublisher<Void, CoreDataError> {
//        <#code#>
//    }
    
}
