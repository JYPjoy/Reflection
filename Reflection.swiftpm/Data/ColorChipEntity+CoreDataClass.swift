import Foundation
import CoreData

@objc(ColorChip)
class ColorChipEntity: NSManagedObject {
    @NSManaged var identifier: UUID
    @NSManaged var colorName: String
    @NSManaged var colorCount: Int
    @NSManaged var colorList: [String]
    @NSManaged var memories: Set<MemoryEntity>
}

extension ColorChipEntity: Identifiable {
    var id: UUID {
        identifier
    }
}
