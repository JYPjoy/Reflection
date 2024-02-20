import SwiftUI

@main
struct MyApp: App {

    init() { DataTransformer.register() }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
