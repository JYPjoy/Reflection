import Foundation
import CoreData

@objc(Memory)
class MemoryEntity: NSManagedObject, Identifiable {
    @NSManaged var identifier: UUID
    @NSManaged var picture: Data?
    @NSManaged var title: String
    @NSManaged var reflection: String
    @NSManaged var colorChip: NSSet
    // 날짜, 위치 정보 추가될 수도
    
    var id: UUID {
        identifier
    }
}

extension MemoryEntity {
    func addColorChip(values: NSSet) {
        let items = self.mutableSetValue(forKey: "colorChip")
        for value in values {
            items.add(value)
        }
    }
    
    func removeColorChip(values: NSSet) {
        let item = self.mutableSetValue(forKey: "colorChip")
        values.forEach{ item.remove($0) }
    }
}
