import SwiftUI

struct MemoryOverView: View {
    @ObservedObject var viewModel = ColorChipViewModel()
    let colorChip: ColorChip
    
    var body: some View {
        HStack {
            Text("컬러칩")
        }
        .navigationTitle(Text("Memories of " + colorChip.colorName))
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

