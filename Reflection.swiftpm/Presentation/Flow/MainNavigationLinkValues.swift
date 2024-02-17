import SwiftUI

enum MainNavigationLinkValues: Hashable, View {
    case colorChip
    case value(title: String)
    
    var body: some View {
        switch self {
        case .colorChip:
            ColorChipView()
        case .value(let title) :
            ValueView(title: title)
        }
    }
}

