import SwiftUI

// TODO: Empty일 때, 처리 필요
struct ColorChipListView: View {
    
    @ObservedObject var viewModel = ColorChipViewModel()
    
    @State private var isButtonActive = false
    @State private var createNewColorChip = false
    @State private var deleteColorChip = false
    @State private var itemToDelete: ColorChip?

    private let column = [
        GridItem(.flexible()),  GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            //colorChipList 가 empty일 때 처리 필요함
            LazyVGrid(columns: column, spacing: 20) {
                ForEach(viewModel.colorChipList, id: \.self) { item in
                    NavigationLink(value:ColorChipNavigationLinkValues.memoryView) {
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
                                    self.deleteColorChip.toggle()
                                }
                               //TODO: 나중에 alert 달기
                                itemToDelete = item
                            }, label: {
                                Image(systemName: "trash")
                                Text("Delete")
                            })
                        })
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.createNewColorChip.toggle()
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
                CreateColorChipView(colorChipViewModel: viewModel)
            }
        }
        .padding()
        .navigationBarTitle(Text("Color Chips"))
    }
}
