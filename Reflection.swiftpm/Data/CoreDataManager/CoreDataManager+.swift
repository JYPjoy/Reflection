import Foundation
import CoreData

// MARK: - Initialize ColorDataManager
extension CoreDataManager {
    // MARK: - ColorChip
    /// Create the colorChip  with all attributes
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
        
        let colorListAttribute = NSAttributeDescription()
        colorListAttribute.name = "colorList"
        colorListAttribute.type = .string
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
        
        /*
         For a to-one relationship, set maxCount to 1.
         For a to-many relationship, set maxCount to a number greater than 1 to impose an upper limit; otherwise, use 0 to allow an unlimited number of referenced objects.
         */
        
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
    
    // MARK: - Memory
    // Create the Memory model with all attributes
    static func createMemory() -> NSEntityDescription {
        let memoryEntity = NSEntityDescription()
        memoryEntity.name = "Memory"
        memoryEntity.managedObjectClassName = "Memory"
        
        let memoryIdAttribute = NSAttributeDescription()
        memoryIdAttribute.name = "identifier"
        memoryIdAttribute.type = .uuid
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

