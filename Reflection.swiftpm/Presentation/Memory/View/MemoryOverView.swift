import SwiftUI

struct MemoryOverView: View {
    @ObservedObject var viewModel = MemoryViewModel()
    @State private var createNewMemory = false
    let colorChip: ColorChip
    
    var body: some View {
        HStack {
            Text("컬러칩")
        }
        .navigationTitle(Text("Memories of " + colorChip.colorName))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.createNewMemory.toggle()
                }, label: {
                    Image(systemName: "plus").fontWeight(.bold)
                    Text("Add new Memory")
                })
            }
        })
        .sheet(isPresented: self.$createNewMemory) {
            NavigationStack {
                MemoryFormView(viewModel: viewModel)
            }
        }
        .onAppear(perform: {
            viewModel.colorChipToAdd = colorChip
        })
    }
}

