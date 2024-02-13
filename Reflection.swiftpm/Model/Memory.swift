import Foundation
import CoreData

@objc(Memory)
class Memory: NSManagedObject {
    @NSManaged var identifier: UUID
    @NSManaged var picture: Data?
    @NSManaged var title: String
    @NSManaged var reflection: String
    @NSManaged var colorChip: NSSet /// colorchip과의 관계 정의를 위함
}

extension Memory: Identifiable {
    var id: UUID {
        identifier
    }
}
