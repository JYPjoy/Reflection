import SwiftUI

struct MemoryOverView: View {
    @ObservedObject var viewModel = MemoryViewModel()
    // @State private var colorChipMemories: [Memory] = []
    @State private var isLoading = true
    
    @State private var createNewMemory = false
    @State private var deleteMemory = false
    @State private var memoryToDelete: Memory?
    @State private var editMemory = false
    @State private var memoryToEdit: Memory?
    
    let colorChip: ColorChip
    
    private let column = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if isLoading {
                    ProgressView("Loading...")
                        .tint(.System.systemBlack)
                        .scaleEffect(1.5)
                        .frame(width: geometry.size.width)
                        .frame(minHeight: geometry.size.height)
                } else if !viewModel.specificColorChipMemories.isEmpty {
                    memoryContainer
                } else {
                    emptyView
                        .padding()
                        .frame(width: geometry.size.width)
                        .frame(minHeight: geometry.size.height)
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
        .sheet(isPresented: self.$editMemory) {
            NavigationStack {
                MemoryFormView(viewModel: viewModel)
            }
        }
        .onAppear(perform: {
            viewModel.specificColorChip = colorChip
            viewModel.fetchSpecificColorChipMemories(colorChip)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isLoading = false
            }
        })
    }
    // MARK: - Inner Container
    var memoryContainer: some View {
        ScrollView{
            LazyVGrid(columns: column, spacing: 5) {
                ForEach(viewModel.specificColorChipMemories, id: \.self) { item in
                    NavigationLink(value:NavigatingCoordinator.memoryDetailView(memory: item, colorChip: colorChip)) {
                        if let picture = item.picture, let pictureImage = UIImage(data: picture) {
                            Image(uiImage: pictureImage)
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .clipped()
                                .accessibilityLabel(Text(item.title))
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
                                    .accessibilityLabel("Photo")
                            }
                        }
    
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text(item.title))
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
                            viewModel.fetchSpecificColorChipMemories(colorChip)
                        }), secondaryButton: .cancel())
                    })
                }
                .border(Color.Text.text90, width: 0.3)
                
            }.padding([.leading, .trailing], 20)
        }
    }
    
    var emptyView: some View {
        VStack(spacing: 40) {
            Text("Seems like you don't have any memories yet.\nClick and Start building your own color schema from your memories.")
                .multilineTextAlignment(.center)
                .font(.title2)
            
            Button(action: {
                withAnimation {
                    self.createNewMemory.toggle()
                }
            }, label: {
                Text("Unfold your memories")
                    .font(.title2).bold()
            })
            .blackButton()
        }
    }
}

