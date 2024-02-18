import SwiftUI

// TODO: Empty일 때, 처리 필요
struct ColorChipListView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var isButtonActive = false
    @State private var createNewColorChip = false
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \ColorChipEntity.colorName, ascending: true)
    ], animation: .default)
    private var colorChipList: FetchedResults<ColorChipEntity>
    private let column = [
        GridItem(.flexible()),  GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: column, spacing: 10) {
                ForEach(colorChipList, id: \.self) { item in
                    NavigationLink(value:ColorChipNavigationLinkValues.value(title: "타이틀")) {
                        VStack {
                            Rectangle()
                                .frame(height: 200)
                                .foregroundStyle(Color(hex:item.colorList))
                            Text(item.colorName).font(.title3).bold()
                            Spacer()
                            Text(item.colorList).font(.subheadline)
                            Spacer().frame(height: 6)
                        }
                        .border(Color.Text.text90, width: 0.3)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        self.createNewColorChip.toggle()
                    }) {
                        Text("Add New Color Chip")
                    }
                    .blackButton()
                    .padding(.top, 30)
                    .padding(.trailing, 5)
                }
            }
            .sheet(isPresented: self.$createNewColorChip) {
                NavigationStack {
                    CreateColorChipView()
                        .environment(\.managedObjectContext, self.viewContext)
                }
            }
        }
        .padding()
        .navigationBarTitle(Text("Color Chips"))
    }
}

