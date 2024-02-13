import SwiftUI
import UIKit


@main
struct MyApp: App {
    @Environment(\.managedObjectContext) var viewContext

    init() { AttributeTransformer.register() }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, RFDBService.shared.container.viewContext)
        }
    }
}
