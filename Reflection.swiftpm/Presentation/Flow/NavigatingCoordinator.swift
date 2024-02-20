import SwiftUI

enum NavigatingCoordinator: Hashable, View {
    case memoryOverView(colorChip: ColorChip)
    case value(title: String)
    
    var body: some View {
        switch self {
        case .memoryOverView(let colorChip):
            MemoryOverView(colorChip: colorChip)
        case .value(let title) :
            ValueView(title: title)
        }
    }
}

