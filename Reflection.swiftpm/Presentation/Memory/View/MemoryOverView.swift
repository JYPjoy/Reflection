import SwiftUI

// TODO: colorChipMemories 있, 없 뷰 구성 달라져야 함
// ContextMenu: 삭제, 편집
struct MemoryOverView: View {
    @ObservedObject var viewModel = MemoryViewModel()
    @State private var colorChipMemories: [Memory] = []
    
    @State private var createNewMemory = false
    @State private var deleteMemory = false
    @State private var memoryToDelete: Memory?
    @State private var editMemory = false
    @State private var memoryToEdit:  Memory?
    
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
                            if let picture = item.picture, let pictureImage = UIImage(data: picture) {
                                Image(uiImage: pictureImage)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipped()
                            } else {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.Text.text90)
                                        .aspectRatio(1, contentMode: .fit)
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.Main.main10)
                                }
                            }
                            
                        }
                        .contextMenu(menuItems: {
                            Button(role: .destructive, action: {
                                withAnimation {
                                    self.memoryToDelete = item
                                    self.deleteMemory.toggle()
                                }
                            }, label: {
                                Image(systemName: "trash")
                                Text("Delete")
                            })
                            Button(role: .cancel, action: {
                                withAnimation {
                                    self.editMemory.toggle()
                                    self.memoryToEdit = item
                                    viewModel.memoryToEdit = item
                                    memoryToEdit = nil
                                }
                            }, label: {
                                Image(systemName: "pencil")
                                Text("Edit")
                            })
                        })
                        .alert(isPresented: self.$deleteMemory, content: {
                            Alert(title: Text("Do you want to delete the " + (memoryToDelete?.title ?? "")), message: Text((memoryToDelete?.title  ?? "")+" will be invisible from the list"), primaryButton: .destructive(Text("Delete"), action: {
                                guard let memoryToDelete = memoryToDelete else {return}
                                
                                viewModel.deleteMemory(memoryToDelete.id)
                            }), secondaryButton: .cancel())
                        })
                    }
                    .border(Color.Text.text90, width: 0.3)
                    
                }.padding([.leading, .trailing], 20)
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
        .sheet(isPresented: self.$editMemory) {
            NavigationStack {
                MemoryFormView(viewModel: viewModel)
            }
        }
        .onAppear(perform: {
            viewModel.specificColorChip = colorChip
            viewModel.specificColorChipMemories = colorChip.memories
            colorChipMemories = colorChip.memories
        })
    }
}

