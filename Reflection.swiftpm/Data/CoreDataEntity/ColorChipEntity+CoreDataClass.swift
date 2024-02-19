import Foundation
import CoreData

@objc(ColorChip)
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
