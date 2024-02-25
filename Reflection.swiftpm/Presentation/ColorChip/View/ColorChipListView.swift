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
        GridItem(.flexible(), spacing: 40),  
        GridItem(.flexible(), spacing: 40),
        GridItem(.flexible(), spacing: 40),
        GridItem(.flexible(), spacing: 40), 
        GridItem(.flexible(), spacing: 40)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if !viewModel.colorChipList.isEmpty {
                    colorListContainer
                } else {
                    emptyView
                    .padding()
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
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
        .navigationBarTitle(Text("My Color Chips"))
        .onAppear {
            viewModel.fetchAllColorChips()
        }
    }
    
    // MARK: - Inner Container
    var colorListContainer: some View {
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
                            .accessibilityLabel("\(item.colorName)")
               
                        Spacer()
                        Text(item.colorList)
                            .padding(.leading, 10)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityHidden(true)
                        Spacer().frame(height: 10)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("This Color's name is"+item.colorName + " \n\n and it's consist of " + ColorManager.shared.hexToRGBAccessibility(hex: item.colorList)))

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
    
    var emptyView: some View {
        VStack(spacing: 40) {
            Text("Seems like you don't have any color chips yet.\nClick and Start making the new one!")
                .multilineTextAlignment(.center)
                .font(.title2)
            
            Button(action: {
                withAnimation {
                    self.createNewColorChip.toggle()
                }
            }, label: {
                Text("Create your first Color Chip")
                    .font(.title2).bold()
            })
            .mainButton()
        }
    }
}
