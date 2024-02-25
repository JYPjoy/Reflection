import SwiftUI

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
                
                ZStack {
                    Rectangle()
                        .stroke(Color.black, lineWidth: 5) // 테두리 색상 및 두께 지정
                        .background(Color.white) // 배경색 설정
                        .foregroundStyle(Color.System.systemWhite)
                        .frame(height: 380)
                    
                    Text("RGB defines the values of red(first number), green(second number), or blue(third number). The number 0 signifies no representation of the color and 255 signifies the highest possible concentration of the color. For example, white is represented as 255, 255, 255. And black is represented as 0, 0, 0.\n\nHex color codes start with a hashtag (#) and are followed by six letters and numbers. The first two refer to red, the next two refer to green, and the last two refer to blue. The color values are defined in values between 00 and FF.For example, white is represented as #ffffff, and black is represented as #000000.\n\nFor more details, try it by yourself on the box above. When you enter a hex Color(without the #), it will automatically convert into RGB. Similarly, When you enter an RGB color, it automatically convert into a hex  Color. Just try it!")
                        .font(.body)
                        .padding(25)
                }
                .padding([.leading, .trailing], 50)
            }
            .padding()
        }
        .navigationTitle(Text("Color Converter"))
    }
    

}

