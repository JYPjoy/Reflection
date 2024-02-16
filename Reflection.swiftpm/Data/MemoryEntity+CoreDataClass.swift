import Foundation
import CoreData

@objc(Memory)
class MemoryEntity: NSManagedObject, Identifiable {
    @NSManaged var identifier: UUID
    @NSManaged var picture: Data?
    @NSManaged var title: String
    @NSManaged var reflection: String
    @NSManaged var colorChip: ColorChipEntity
    // 날짜, 위치 정보 추가될 수도
    
    var id: UUID {
        identifier
    }
}
