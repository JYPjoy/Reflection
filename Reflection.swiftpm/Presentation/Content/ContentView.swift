import SwiftUI

struct ContentView: View {

    @AppStorage("currentView ") var currentView: Int = 0
    
    var body: some View {
        if self.currentView > 3 {
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
                } // backgroundColor 바꾸기 가능
            }
        } else {
            OnboardingView(currentView: self.$currentView)
        }
    }
}
