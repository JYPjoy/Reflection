import Foundation

struct ColorChip: Hashable {

    var id: UUID
    var colorName: String
    var colorList: String
    var memories: [Memory] //여긴 메모리인데 -> MemoryEntiy 변환
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ColorChip: Comparable {

    static func < (lhs: ColorChip, rhs: ColorChip) -> Bool {
        if lhs.colorName == rhs.colorName { return lhs.id.uuidString < rhs.id.uuidString }
        return lhs.colorName < rhs.colorName
    }
    
    static func == (lhs: ColorChip, rhs: ColorChip) -> Bool {
        return lhs.id == rhs.id
    }
    
}
