import SwiftUI

struct MainView: View {
    
    private var data  = Array(1...20)
    private let column = [
        GridItem(.flexible()),  GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView{
            
            Button {
                print("hi")
            } label: {
                Text("New Color")
            }
            .blackButton()
            
            LazyVGrid(columns: column, spacing: 30) {
                ForEach(data, id: \.self) { item in
                    VStack {
                        Rectangle()
                            .frame(width: 180, height: 180, alignment: .center)
                            .overlay(
                                LinearGradient(colors: [.green, .yellow], startPoint: .top, endPoint: .bottom)
                            )
                        Text("color Name").font(.title3)
                        Spacer()
                        Text("hex").font(.subheadline)
                        Spacer().frame(height: 6)
                    }
                    .border(Color(.text90), width: 0.3)
                    .onTapGesture { print("Click") }
                }
            }
        } .padding()
    }
}
