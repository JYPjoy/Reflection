import SwiftUI
import Combine
import CoreData

// MARK: - Managable
protocol ColorChipManagable {
    func insertColorChip(_ colorChip: ColorChipEntity) -> AnyPublisher<ColorChipEntity, CoreDataManager.CoreDataError>
    func fetchAllColorChip() -> AnyPublisher<[ColorChipEntity], CoreDataManager.CoreDataError>
    
    func updateColorChip(_ colorChip: ColorChipEntity) -> AnyPublisher<ColorChipEntity, CoreDataManager.CoreDataError>
    func deleteColorChip(id: UUID) -> AnyPublisher<Void, CoreDataManager.CoreDataError>
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
}

//extension CoreDataManager: ColorChipManagable {
//    func insertColorChip(_ colorChip: ColorChipEntity) -> AnyPublisher<ColorChipEntity, CoreDataError> {
////        return Future { promise in
////            self.backgroundContext.perform {
////                let gatheringEntity = ColorChipEntity(context: self.backgroundContext, gathering: gathering)
////                gatheringEntity.addToBuddyList(NSSet(array: self.fetchBuddyEntity(of: gathering.buddyList)))
////                gatheringEntity.addToPurposeList(NSSet(array: self.fetchPurposeEntity(of: gathering.purpose)))
////                
////                do {
////                    try self.backgroundContext.save()
////                    promise(.success(gatheringEntity))
////                } catch let error {
////                    print(error)
////                    promise(.failure(.gatheringInsert))
////                }
////            }
////        }.eraseToAnyPublisher()
//    }
//    
//    func fetchAllColorChip() -> AnyPublisher<[ColorChipEntity], CoreDataError> {
//        <#code#>
//    }
//    
//    func updateColorChip(_ colorChip: ColorChipEntity) -> AnyPublisher<ColorChipEntity, CoreDataError> {
//        <#code#>
//    }
//    
//    func deleteColorChip(id: UUID) -> AnyPublisher<Void, CoreDataError> {
//        <#code#>
//    }
//    
//    
//}

