import Foundation
import CoreData

@objc(Memory)
class MemoryEntity: NSManagedObject {
    @NSManaged var identifier: UUID
    @NSManaged var picture: Data?
    @NSManaged var title: String
    @NSManaged var reflection: String
    @NSManaged var colorChip: NSSet /// colorchip과의 관계 정의를 위함
    // 날짜, 위치 정보 추가될 수도
}

extension MemoryEntity: Identifiable {
    var id: UUID {
        identifier
    }
}
