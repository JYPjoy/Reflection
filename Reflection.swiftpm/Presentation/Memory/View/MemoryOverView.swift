import SwiftUI

struct MemoryOverView: View {
    @ObservedObject var viewModel = ColorChipViewModel()
    let title: String
    
    var body: some View {
        HStack {
            Text("컬러칩")
        }
        .navigationTitle(Text("Memories of " + title))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus").fontWeight(.bold)
                    Text("Add new Memory")
                })
            }
        })
    }
}

