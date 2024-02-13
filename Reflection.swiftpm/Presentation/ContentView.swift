import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
//    @ObservedObject var colorChip: ColorChip
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                Text("Hello, world!")
                    .foregroundStyle(Color.Main.main50)
                Button {
                    //CustomDataTransformer.register()
                    SampleData.shared.createSampleData()
                } label: {
                    Text("Update Data")
                }

                NavigationLink {
                    SecondView()
                        .environment(\.managedObjectContext, self.viewContext)
                    //print(colorChip.id, colorChip.colorName, colorChip.colorList)
                } label: {
                    Text("HI")
                }

            }
        }
    }
}
