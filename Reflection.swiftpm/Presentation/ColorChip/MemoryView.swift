import SwiftUI

struct MemoryView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        HStack {
            Text("컬러칩")
        }
        .navigationTitle(Text("Memories"))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    
                }, label: {
                    Text("Edit")
                })
            }
        })
    }
    
}
