import Foundation
import CoreData

@objc(ColorChip)
class ColorChip: NSManagedObject {
    @NSManaged var identifier: UUID
    @NSManaged var colorName: String
    @NSManaged var colorCount: Int
    @NSManaged var colorList: [String]
    @NSManaged var memories: NSSet
}

extension ColorChip: Identifiable {
    var id: UUID {
        identifier
    }
}
