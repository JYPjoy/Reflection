import SwiftUI

// TODO: HEX, RGB 관련 짧은 지식 넣어주기 = 내용 다시 보고 수정하도록 하기
// TODO: 계속 -
struct ConverterView: View {
    @State private(set) var backgroundColor: Color = .white
    @State private(set) var hexColor: String = "FFFFFF"
    @State private(set) var rgbColor: String = "255,255,255"
    
    var body: some View {
        
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack(spacing: 30) {
                
                // HEX
                HStack(spacing: 10) {
                    Image(systemName: "number").font(.title2).bold()
                    TextField("HEX(ex: F8D749)", text: self.$hexColor)
                        .font(.title2).bold()
                        .padding([.leading, .trailing], 30)
                        .frame(width: 600, height: 50)
                        .onChange(of: hexColor) { newValue in
                            backgroundColor = Color(hex: hexColor)
                            if newValue.count == 6 {
                                rgbColor = ColorManager.shared.hexToRGB(hex: "#" + newValue)
                            } else if newValue.count > 6 {
                                rgbColor = String(newValue.prefix(newValue.count - 1))
                            }
                        }
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.System.systemBlack, lineWidth: 5)
                )
                
                // RGB
                HStack(spacing: 10) {
                    Image(systemName: "paintbrush").font(.title2).bold()
                    TextField("RGB(ex: 248,215,73)", text: self.$rgbColor) //#달려야 함
                        .font(.title2).bold()
                        .padding([.leading, .trailing], 30)
                        .frame(width: 600, height: 50)
                        .onChange(of: rgbColor) { newValue in
                            let rgbArray = newValue.components(separatedBy: ",")
                                                  .prefix(3)
                                                  .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
                            if rgbArray.count == 3, rgbArray.allSatisfy({ 0...255 ~= $0 })
                         {
                                backgroundColor = Color(hex: "#" + ColorManager.shared.rgbToHex(r: rgbArray[0], g: rgbArray[1], b: rgbArray[2]))
                                hexColor = ColorManager.shared.rgbToHex(r: rgbArray[0], g: rgbArray[1], b: rgbArray[2])
                            }
                            
                        }
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.System.systemBlack, lineWidth: 5)
                )
                Spacer().frame(height:10)
                
                ZStack {
                    Rectangle()
                        .stroke(Color.black, lineWidth: 5) // 테두리 색상 및 두께 지정
                        .background(Color.white) // 배경색 설정
                        .foregroundStyle(Color.System.systemWhite)
                        .frame(height: 300)
                    
                    Text("RGB is consist of combinations of red, green, and blue, each ranging from 0 to 255.\nFor example, white is represented as 255, 255, 255. And black is represented as 0, 0, 0.\n \nHEX color is expressed as a six-digit combination of numbers(0-9) and letters(A-F) defined by its mix of red, green and blue (RGB). For example, white is #FFFFFF.\n\nFor more details, try it by yourself on the box above. When you enter a hex Color(without the#), it will automatically convert into RGB. Similarly, When you enter an RGB color, it automatically convert into a hexColor. Just try it!")
                        .font(.body)
                        .padding(20)
                }
                .padding([.leading, .trailing], 100)
            }
            .padding()
        }
        .navigationTitle(Text("Color Converter"))
    }
    

}

