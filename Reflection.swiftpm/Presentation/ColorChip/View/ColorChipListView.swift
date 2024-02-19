import SwiftUI

// TODO: Empty일 때, 처리 필요
// 버튼 뒤로 나갔다 돌아왔을 때 잘려보이는 문제 해결해야 함
struct ColorChipListView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var isButtonActive = false
    @State private var createNewColorChip = false
    @State private var deleteColorChip = false
    
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \ColorChipEntity.colorName, ascending: true)
    ], animation: .default)
    private var colorChipList: FetchedResults<ColorChipEntity>
    
    private let column = [
        GridItem(.flexible()),  GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            //colorChipList 가 empty일 때 처리 필요함
            LazyVGrid(columns: column, spacing: 20) {
                ForEach(colorChipList, id: \.self) { item in
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
                CreateColorChipView()
            }
            
        }
        .padding()
        .navigationBarTitle(Text("Color Chips"))
    }
    
}
