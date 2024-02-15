import Foundation

struct Memory {
    var identifier: UUID
    var picture: Data?
    var title: String
    var reflection: String
    var colorChip: NSSet /// colorchip과의 관계 정의를 위함
    // 날짜, 위치 정보 추가될 수도
}
