import SwiftUI

struct ColorChipView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var isButtonActive = false
    
    private var data  = Array(1...20)
        private let column = [
            GridItem(.flexible()),  GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
        ]

    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: column, spacing: 10) {
                ForEach(data, id: \.self) { item in
                    NavigationLink(value: //MainNavigationLinkValues.colorChip) {
                        MainNavigationLinkValues.value(title: "타이틀")) {
                        VStack {
                            Rectangle()
                                .frame(width: 160, height: 160, alignment: .center)
                                .overlay(
                                    LinearGradient(colors: [.green, .yellow], startPoint: .top, endPoint: .bottom)
                                )
                            Text("color Name").font(.title3)
                            Spacer()
                            Text("hex").font(.subheadline)
                            Spacer().frame(height: 6)
                        }
                        .border(Color(.text90), width: 0.3)
                        
                    }
                }
            }
        } 
        .padding()
        .navigationBarTitle(Text("ColorChips"))
    }
}

