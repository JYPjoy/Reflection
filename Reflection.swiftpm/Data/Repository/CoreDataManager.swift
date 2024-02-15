import SwiftUI
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
    let container : NSPersistentContainer

    init(inMemory: Bool = false) {
        let container = NSPersistentContainer(name: "ColorChipModel", managedObjectModel: CoreDataManager.createColorChip())
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("failed with \(error.localizedDescription)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        self.container = container
    }
}


// MARK:  - 여기서부터 RepositoryImpl로 가야 함
extension CoreDataManager {
    
    // MARK: - ColorChip Model
    static func createColorChip() -> NSManagedObjectModel {
        /// ColorChip 관련 코드
        let colorChipEntity = NSEntityDescription()
        colorChipEntity.name = "ColorChip"
        colorChipEntity.managedObjectClassName = "ColorChip"
        
        let colorIdAttribute = NSAttributeDescription()
        colorIdAttribute.name = "identifier"
        colorIdAttribute.type = .uuid
        colorChipEntity.properties.append(colorIdAttribute)
        
        let colorNameAttribute = NSAttributeDescription()
        colorNameAttribute.name = "colorName"
        colorNameAttribute.type = .string
        colorChipEntity.properties.append(colorNameAttribute)
        
        let colorCountAttribute = NSAttributeDescription()
        colorCountAttribute.name = "colorCount"
        colorCountAttribute.type = .integer64
        colorChipEntity.properties.append(colorCountAttribute)
        
        let colorListAttribute = NSAttributeDescription()
        colorListAttribute.name = "colorList"
        colorListAttribute.attributeType = .transformableAttributeType
        colorListAttribute.isOptional = true
        colorListAttribute.valueTransformerName = String(describing: DataTransformer.self)
        colorChipEntity.properties.append(colorListAttribute)
        
        let model = NSManagedObjectModel()
        
        /// ColorChip 과 Memory 간의 관계 정의
        let memory = CoreDataManager.createMemory()
        let memoryRelation = NSRelationshipDescription()
        memoryRelation.destinationEntity = memory
        memoryRelation.name = "memories"
        memoryRelation.minCount = 0
        memoryRelation.maxCount = 0
        memoryRelation.isOptional = true
        memoryRelation.deleteRule = .nullifyDeleteRule
        
        let colorChipRelation = NSRelationshipDescription()
        colorChipRelation.destinationEntity = colorChipEntity
        colorChipRelation.name = "colorChip"
        colorChipRelation.minCount = 0
        colorChipRelation.maxCount = 0
        colorChipRelation.isOptional = true
        colorChipRelation.deleteRule = .nullifyDeleteRule
        
        memoryRelation.inverseRelationship = colorChipRelation
        colorChipRelation.inverseRelationship = memoryRelation
        
        colorChipEntity.properties.append(memoryRelation)
        memory.properties.append(colorChipRelation)

        model.entities = [colorChipEntity, memory]
        return model
    }
    
    // MARK: - Memory Model
    static func createMemory() -> NSEntityDescription {
        let memoryEntity = NSEntityDescription()
        memoryEntity.name = "Memory"
        memoryEntity.managedObjectClassName = "Memory"
        
        let memoryIdAttribute = NSAttributeDescription()
        memoryIdAttribute.name = "id"
        memoryIdAttribute.type = .string
        memoryEntity.properties.append(memoryIdAttribute)
        
        let memoryPictureAttribute = NSAttributeDescription()
        memoryPictureAttribute.name = "picture"
        memoryPictureAttribute.type = .binaryData
        memoryEntity.properties.append(memoryPictureAttribute)
        
        let memoryTitleAttribute = NSAttributeDescription()
        memoryTitleAttribute.name = "title"
        memoryTitleAttribute.type = .string
        memoryEntity.properties.append(memoryTitleAttribute)
        
        let memoryReflectionAttribute = NSAttributeDescription()
        memoryReflectionAttribute.name = "reflection"
        memoryReflectionAttribute.type = .string
        memoryEntity.properties.append(memoryReflectionAttribute)
        
        return memoryEntity
    }
}