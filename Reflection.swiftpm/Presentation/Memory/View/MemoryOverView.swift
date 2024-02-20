import SwiftUI

struct MemoryOverView: View {
    @ObservedObject var viewModel = ColorChipViewModel()
    
    var body: some View {
        HStack {
            Text("컬러칩")
        }
        .navigationTitle(Text("Memories"))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("Add new Memory")
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Edit")
                    })
                }
            }
        })
    }
}

