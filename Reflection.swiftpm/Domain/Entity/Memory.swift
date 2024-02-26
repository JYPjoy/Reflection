import Foundation

struct Memory: Hashable {
    var id: UUID
    var picture: Data?
    var title: String
    var date: Date
    var reflection: String
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
