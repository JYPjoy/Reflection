import SwiftUI

enum MainNavigationLinkValues: Hashable, View {
    case colorChip
    
    var body: some View {
        switch self {
        case .colorChip:
            ColorChipView()

        }
    }
}

