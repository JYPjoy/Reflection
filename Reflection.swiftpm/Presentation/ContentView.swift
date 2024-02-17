import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State var selectedTab: Int = 1

    var body: some View {
        Group {
            TabView(selection: self.$selectedTab) {
                NavigationView {
                    MainView()
                        .environment(\.managedObjectContext, self.viewContext)
                        .navigationBarTitle(Text("ColorChips"))
                }
                .tabItem {
                    VStack {
                        Image(systemName: "paintpalette")
                        Text("ColorChips")
                            .font(.body.bold())
                    }
                }
                .tag(0)
                
                NavigationView {
                    NewColorView()
                        .environment(\.managedObjectContext, self.viewContext)
                        .navigationBarTitle("Converter")
                }
                .tabItem {
                    VStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                        Text("Converter")
                            .font(.body.bold())
                    }
                }
                .tag(1)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
