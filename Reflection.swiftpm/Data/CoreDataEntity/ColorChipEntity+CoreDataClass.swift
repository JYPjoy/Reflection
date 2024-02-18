import Foundation
import CoreData

@objc(ColorChip)
class ColorChipEntity: NSManagedObject, Identifiable {
    @NSManaged var identifier: UUID
    @NSManaged var colorName: String
    @NSManaged var colorCount: Int
    @NSManaged var colorList: [String]
    @NSManaged var memories: NSSet
    
    var id: UUID {
        identifier
    }
}

extension ColorChipEntity {
    func addMemory(values: NSSet) {
        let item = self.mutableSetValue(forKey: "memories")
        values.forEach{ item.add($0) }
    }
    
    func removeMemory(values: NSSet) {
        let item = self.mutableSetValue(forKey: "memories")
        values.forEach{ item.remove($0) }
    }
}
