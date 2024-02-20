import SwiftUI

struct ColorChipListView: View {
    
    @ObservedObject var viewModel = ColorChipViewModel()
    
    @State private var isButtonActive = false
    @State private var createNewColorChip = false
    
    @State private var deleteColorChip = false
    @State private var itemToDelete: ColorChip?
    
    @State private var editColorChip = false
    @State private var itemToEdit: ColorChip?

    private let column = [
        GridItem(.flexible(), spacing: 40),  GridItem(.flexible(), spacing: 40), GridItem(.flexible(), spacing: 40), GridItem(.flexible(), spacing: 40), GridItem(.flexible(), spacing: 40)
    ]
    
    var body: some View {
        ScrollView {
            //TODO: colorChipList 가 empty일 때 처리 필요함 (뷰 둘로 나누기)
            LazyVGrid(columns: column, spacing: 40) {
                ForEach(viewModel.colorChipList, id: \.self) { item in
                    NavigationLink(value:NavigatingCoordinator.memoryOverView(colorChip: item)) {
                        VStack {
                            Rectangle()
                                .frame(height: 200)
                                .foregroundStyle(Color(hex:item.colorList))
                            Text(item.colorName)
                                .padding(.leading, 10)
                                .font(.title3).bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            Text(item.colorList)
                                .padding(.leading, 10)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer().frame(height: 10)
                        }
                        .border(Color.Text.text90, width: 0.3)
                        .contextMenu(menuItems: {
                            Button(role: .destructive, action: {
                                withAnimation {
                                    self.itemToDelete = item
                                    self.deleteColorChip.toggle()
                                }
                            }, label: {
                                Image(systemName: "trash")
                                Text("Delete")
                            })
                            Button(role: .cancel, action: {
                                withAnimation {
                                    self.editColorChip.toggle()
                                    self.itemToEdit = item
                                    viewModel.colorChipToEdit = itemToEdit
                                    itemToEdit = nil
                                }
                            }, label: {
                                Image(systemName: "pencil")
                                Text("Edit")
                            })
                        })
                        .alert(isPresented: self.$deleteColorChip, content: {
                            Alert(title: Text("Do you want to delete the " + (itemToDelete?.colorName ?? "")), message: Text((itemToDelete?.colorName ?? "")+" will be invisible from the list"), primaryButton: .destructive(Text("Delete"), action: {
                                guard let itemToDelete = itemToDelete else {return}
                                viewModel.deleteColorChip(itemToDelete.id)
                            }), secondaryButton: .cancel())
                        })
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.createNewColorChip.toggle()
                    itemToEdit = nil
                    viewModel.colorChipToEdit = itemToEdit
                }) {
                    HStack {
                        Image(systemName: "plus").fontWeight(.bold)
                        Text("Add New Color Chip")
                    }
                }
            }
        }
        .sheet(isPresented: self.$createNewColorChip) {
            NavigationStack {
                ColorChipFormView(viewModel: viewModel)
            }
        }
        .sheet(isPresented: self.$editColorChip) {
            NavigationStack {
                ColorChipFormView(viewModel: viewModel)
            }
        }
        .padding()
        .navigationBarTitle(Text("Color Chips"))
    }
}
