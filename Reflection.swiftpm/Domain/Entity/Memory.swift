import Foundation

struct Memory: Hashable {
    var id: UUID
    var picture: Data?
    var title: String
    var reflection: String
    // 날짜, 위치 정보 추가될 수도
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Memory: Comparable {
    static func < (lhs: Memory, rhs: Memory) -> Bool {
        if lhs.title == rhs.title { return lhs.id.uuidString < rhs.id.uuidString }
        return lhs.title < rhs.title
    }
    
    static func == (lhs: Memory, rhs: Memory) -> Bool {
        return lhs.id == rhs.id
    }
}
