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
