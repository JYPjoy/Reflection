import SwiftUI
import UIKit


@main
struct MyApp: App {
    @Environment(\.managedObjectContext) var viewContext
    
    init() { DataTransformer.register() }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
//                .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
            
        }
    }
}
