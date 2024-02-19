import Foundation
import CoreData

@objc(ColorChipEntity)
class ColorChipEntity: NSManagedObject, Identifiable {
    @NSManaged public var identifier: UUID
    @NSManaged public var colorName: String
    @NSManaged public var colorList: String //hex값 담기게 됨
    
    @NSManaged public var memories: Set<MemoryEntity>
    
    var id: UUID {
        identifier
    }
}

extension ColorChipEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ColorChipEntity> {
        return NSFetchRequest<ColorChipEntity>(entityName: "ColorChipEntity")
    }

    @objc(addMemoriesObject:)
    @NSManaged public func addToMemories(_ value: MemoryEntity)

    @objc(removeMemoriesObject:)
    @NSManaged public func removeFromMemories(_ value: MemoryEntity)

    @objc(addMemories:)
    @NSManaged public func addToMemories(_ values: NSSet)

    @objc(removeMemories:)
    @NSManaged public func removeFromMemories(_ values: NSSet)
    
}

extension ColorChipEntity {
    
    convenience init(context: NSManagedObjectContext, colorChip: ColorChip) {
        self.init(context: context)
        self.identifier = colorChip.id
        self.colorName = colorChip.colorName
        self.colorList = colorChip.colorList
    }
    
    func toDomain() -> ColorChip {
        return ColorChip(id: self.identifier, colorName: self.colorName, colorList: self.colorList, memories: self.memories.map{ $0.toDomain() })
    }
    
    // MARK: - 리팩터링 필요함
    func addMemory(values: NSSet) {
        let item = self.mutableSetValue(forKey: "memories")
        values.forEach{ item.add($0) }
    }
    
    func removeMemory(values: NSSet) {
        let item = self.mutableSetValue(forKey: "memories")
        values.forEach{ item.remove($0) }
    }
}

extension ColorChipEntity: Comparable {
    
    public static func < (lhs: ColorChipEntity, rhs: ColorChipEntity) -> Bool {
        return lhs.id < rhs.id
    }
}
