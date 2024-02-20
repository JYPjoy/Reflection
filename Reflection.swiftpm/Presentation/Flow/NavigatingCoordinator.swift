import SwiftUI

enum NavigatingCoordinator: Hashable, View {
    case memoryOverView(title: String)
    case value(title: String)
    
    var body: some View {
        switch self {
        case .memoryOverView(let title):
            MemoryOverView(title: title)
        case .value(let title) :
            ValueView(title: title)
        }
    }
}

