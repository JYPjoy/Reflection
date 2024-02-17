import SwiftUI
import UIKit


@main
struct MyApp: App {
    @Environment(\.managedObjectContext) var viewContext
    
    init() { DataTransformer.register() }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                //MainView()
                    .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
                //                 .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
                
            }
        }
    }
}
