import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext

    var body: some View {
        Group {
            TabView {
                MainView()
                    .environment(\.managedObjectContext, self.viewContext)
                    .navigationLinkValues(MainNavigationLinkValues.self)
                    .tabItem {
                        VStack {
                            Image(systemName: "paintpalette")
                            Text("ColorChips")
                                .font(.body.bold())
                        }
                    }
                
                ConverterView()
                    .environment(\.managedObjectContext, self.viewContext)
                    .tabItem {
                        VStack {
                            Image(systemName: "arrow.triangle.2.circlepath")
                            Text("Converter")
                                .font(.body.bold())
                        }
                    }
            } // backgroundColor 바꾸기 가능
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
