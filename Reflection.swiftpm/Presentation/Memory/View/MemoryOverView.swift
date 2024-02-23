import SwiftUI

struct MemoryOverView: View {
    @ObservedObject var viewModel = MemoryViewModel()
    @State private var createNewMemory = false
    @State private var colorChipMemories: [Memory] = []
    let colorChip: ColorChip
    
    private let column = [
        GridItem(.flexible(), spacing: 5),  GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)
    ]
    
    var body: some View {
        Group{
            ScrollView{
                LazyVGrid(columns: column, spacing: 5) {
                    ForEach(viewModel.specificColorChipMemories, id: \.self) { item in
                        NavigationLink(value:NavigatingCoordinator.memoryDetailView) {
                            VStack {
                                Rectangle()
                                    .aspectRatio(1, contentMode: .fit)
                            }
                            .border(Color.Text.text90, width: 0.3)
                        }
                    }
                }
            }
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
            viewModel.specificColorChip = colorChip
            viewModel.specificColorChipMemories = colorChip.memories
            colorChipMemories = colorChip.memories
            Log.c(colorChipMemories)
          
        })
    }
}

