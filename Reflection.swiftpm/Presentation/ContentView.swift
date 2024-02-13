import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext

    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                Text("Hello, world!")
                    .foregroundStyle(Color.Main.main50)
                Button {
                    SampleData.shared.createSampleData()
                } label: {
                    Text("Update Data")
                }

                NavigationLink {
                    SecondView()
                        .environment(\.managedObjectContext, self.viewContext)
                } label: {
                    Text("HI")
                }

            }
        }
    }
}
