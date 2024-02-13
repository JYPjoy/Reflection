import Foundation
import CoreData

@objc(ColorChip)
class ColorChip: NSManagedObject {
    @NSManaged var identifier: UUID
    @NSManaged var colorName: String
    @NSManaged var colorList: [String]
    @NSManaged var memories: NSSet
}

extension ColorChip: Identifiable {
    var id: UUID {
        identifier
    }
    
    /// Add memories to the ColorChip
    func addMemory(values: NSSet) {
        values.forEach { self.mutableSetValue(forKey: "memories").add($0) }
    }
    
    /// Remove memories from the Colorchip
    func removeMemory(values: NSSet) {
        values.forEach { self.mutableSetValue(forKey: "memories").remove($0) }
    }
}
