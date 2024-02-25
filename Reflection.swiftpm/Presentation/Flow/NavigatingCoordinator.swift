import SwiftUI

enum NavigatingCoordinator: Hashable, View {
    case memoryOverView(colorChip: ColorChip)
    case memoryDetailView(memory: Memory, colorChip: ColorChip)
    
    var body: some View {
        switch self {
        case .memoryOverView(let colorChip):
            MemoryOverView(colorChip: colorChip)
        case .memoryDetailView(let memory, let colorChip):
            MemoryDetailedView(memory: memory, colorChip: colorChip)
        }
    }
}

