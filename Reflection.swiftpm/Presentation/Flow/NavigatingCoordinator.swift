import SwiftUI

enum NavigatingCoordinator: Hashable, View {
    case memoryOverView(colorChip: ColorChip)
    
    var body: some View {
        switch self {
        case .memoryOverView(let colorChip):
            MemoryOverView(colorChip: colorChip)
        }
    }
}

