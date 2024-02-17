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
            LazyVGrid(columns: column, spacing: 10) {
                ForEach(data, id: \.self) { item in
                    VStack {
                        Rectangle() //TODO: 크기 조정 필요
                            .frame(width: 160, height: 160, alignment: .center)
                            .overlay(
                                LinearGradient(colors: [.green, .yellow], startPoint: .top, endPoint: .bottom)
                            )
                        Text("color Name").font(.title3)
                        Spacer()
                        Text("hex").font(.subheadline)
                        Spacer().frame(height: 6)
                    }
                    .border(Color.Text.text90, width: 0.3)
                    .onTapGesture { print("Click") }
                }
            }
        } .padding()
    }
}
