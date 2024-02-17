import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
            NavigationLink {
                SecondView()
            } label: {
                Text("다음 뷰로 이동하기")
            }

    }
}
