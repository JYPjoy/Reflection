import SwiftUI
import Combine
import CoreData

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
    
    
    //MARK: - CRUD
    func create(object: NSManagedObject) -> Bool {
        do {
            context.insert(object)
            try context.save()
            return true
        } catch {
            print(CoreDataError.create)
            return false
        }
    }
    
    func read(predicate: NSPredicate? = nil) -> [NSManagedObject] {
        let request = NSManagedObject.fetchRequest()
        request.predicate = predicate
        
        do {
            return try context.fetch(request) as? [NSManagedObject] ?? []
        } catch {
            print(CoreDataError.read)
            return []
        }
    }
    
    func update(object: NSManagedObject) -> Bool {
        do {
            try context.save()
            return true
        } catch {
            print(CoreDataError.update)
            return false
        }
    }
    
    func delete(object: NSManagedObject) -> Bool {
        context.delete(object)
        do {
            try context.save()
            return true
        } catch {
            print(CoreDataError.update)
            return false
        }
    }
}

