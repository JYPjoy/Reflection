import SwiftUI

struct ContentView: View {

    var body: some View {
        Group {
            TabView {
                ColorChipListView()
                    .navigationLinkValues(NavigatingCoordinator.self)
                    .tabItem {
                        VStack {
                            Image(systemName: "paintpalette")
                            Text("Color Chips")
                                .font(.body.bold())
                        }
                    }
                
                ConverterView()
                    .navigationLinkValues(NavigatingCoordinator.self)
                    .tabItem {
                        VStack {
                            Image(systemName: "arrow.triangle.2.circlepath")
                            Text("Converter")
                                .font(.body.bold())
                        }
                    }
                
                MemoryDetailedView()
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
