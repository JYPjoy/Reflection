import SwiftUI

enum NavigatingCoordinator: Hashable, View {
    case memoryOverView(colorChip: ColorChip)
    case memoryDetailView(memory: Memory)
    
    var body: some View {
        switch self {
        case .memoryOverView(let colorChip):
            MemoryOverView(colorChip: colorChip)
        case .memoryDetailView(let memory):
            MemoryDetailedView(memory: memory)
        }
    }
}

