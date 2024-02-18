import SwiftUI

struct CreateColorChipView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State private var colorName: String = ""
    @State private var colorCountText = ""
    @State private var colorCount: Int = 0
    @State private var colorList: [Color] = []
    
    var body: some View {
        VStack {
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
                                .cornerRadius(10)
                        }.mainButton()
                    }
                } header: {
                    Text("The number of colors")
                }
                
                
                // SECTION 3
                Section {
                    // ColorPicker 배열을 동적으로 생성
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
                
                Button {
                    print(colorList)
                    self.dismiss()
                } label: {
                    Text("Make a Color Chip")
                }
                .blackButton()
            }
        }
        .navigationTitle(Text("Create a New Color Chip"))
    }
}
