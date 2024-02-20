import SwiftUI

enum ColorChipNavigationLinkValues: Hashable, View {
    case memoryView
    case value(title: String)
    
    var body: some View {
        switch self {
        case .memoryView:
            MemoryOverView()
        case .value(let title) :
            ValueView(title: title)
        }
    }
}

