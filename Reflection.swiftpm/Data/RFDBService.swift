import SwiftUI
import CoreData

class RFDBService {
    static let shared = RFDBService()
    
    let container : NSPersistentContainer

    init(inMemory: Bool = false) {
        let container = NSPersistentContainer(name: "ColorChipModel", managedObjectModel: RFDBService.createColorChip())
        
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

extension RFDBService {
    
    // MARK: - ColorChip Model
    static func createColorChip() -> NSManagedObjectModel {
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
        model.entities = [colorChipEntity]
        return model
    }
}
