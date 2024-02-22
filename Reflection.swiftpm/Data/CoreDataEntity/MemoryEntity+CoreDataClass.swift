import Foundation
import CoreData

@objc(MemoryEntity)
final class MemoryEntity: NSManagedObject, Identifiable {
    @NSManaged public var identifier: UUID
    @NSManaged public var picture: Data?

    @NSManaged public var title: String
    @NSManaged public var date: Date
    @NSManaged public var reflection: String
    @NSManaged var colorChip: Set<ColorChipEntity>
    // 날짜, 위치 정보 추가될 수도
    
    var id: UUID {
        identifier
    }
}

extension MemoryEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoryEntity> {
        return NSFetchRequest<MemoryEntity>(entityName: "MemoryEntity")
    }
    
    @objc(addColorChipObject:)
    @NSManaged public func addToColorChip(_ value: ColorChipEntity)

    @objc(removeColorChipObject:)
    @NSManaged public func removeFromColorChip(_ value: ColorChipEntity)

    @objc(addColorChip:)
    @NSManaged public func addToColorChip(_ values: NSSet)

    @objc(removeColorChip:)
    @NSManaged public func removeFromColorChip(_ values: NSSet)
}

extension MemoryEntity {
    
    @discardableResult
    convenience init(context: NSManagedObjectContext, memory: Memory) {
        self.init(context: context)
        self.identifier = memory.id
        self.picture = memory.picture
        self.title = memory.title
        self.date = memory.date
        self.reflection = memory.reflection
    }
    
    func toDomain() -> Memory {
        return Memory(id: self.id, picture: self.picture, title: self.title, date: self.date, reflection: self.reflection)
    }
}
