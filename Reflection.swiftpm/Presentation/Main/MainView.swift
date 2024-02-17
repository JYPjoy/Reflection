import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        NavigationLink(value: MainNavigationLinkValues.colorChip) {
            Text("컬러칩뷰로 이동")
        }

    }
}
