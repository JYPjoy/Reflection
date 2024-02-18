import SwiftUI

// TODO: 버튼 비활성화, 더 친절한 form이 되도록 안내 문구 함께 나오도록 하기
// 컴포넌트 크기 조정 필요
struct CreateColorChipView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State private var colorName: String = ""
    @State private var colorCountText = ""
    @State private var colorCount: Int = 0
    @State private var colorList: [Color] = []
    
    var body: some View {
        VStack {
            // MARK: - Form
            Form {
                // SECTION1
                Section {
                    TextField("Color Name", text: self.$colorName)
                } header: {
                    Text("Color Name") // 커스텀화 가능 .font(.body).bold()
                }
                
                // SECTION2
                Section {
                    VStack{
                        TextField("How many Colors do you want to mix?", text: $colorCountText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .padding(.trailing, 4)
                        
                        Button {
                            if let colorCount = Int(colorCountText), colorCount > 0 {
                                self.colorCount = colorCount
                                colorList = Array(repeating: Color.Main.main50, count: colorCount)
                            }
                        } label: {
                            Text("Generate the ColorPickers")
                                .frame(maxWidth: .infinity, minHeight: 20)
                        }.mainButton()
                    }
                } header: {
                    Text("The number of colors")
                }
                
                
                // SECTION 3 (리팩터링 하기)
                Section {
                    ForEach(0..<colorCount, id: \.self) { idx in
                        ColorPicker("Selected Color \(idx + 1)",
                                    selection: Binding(get: {
                            colorList.indices.contains(idx) ? colorList[idx] : Color.Main.main50
                        }, set: { selectedColor in
                            if colorList.indices.contains(idx) {
                                colorList[idx] = selectedColor
                            }
                        })
                        )
                        .padding()
                    }
                } header: {
                    Text("Select the colors")
                }
            }
            
            // MARK: - Button
            Button {
                print(colorList)
                self.dismiss()
            } label: {
    
                    Text("Make a Color Chip")
                    .frame(maxWidth: .infinity, minHeight: 20)
       
            }
            //.diabled()
            .blackButton()
            .padding(30)
        }
        .navigationTitle(Text("Create a New Color Chip"))
    }
}
