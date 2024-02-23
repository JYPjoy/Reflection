import SwiftUI

// TODO: HEX, RGB 관련 짧은 지식 넣어주기
// TODO: 계속
struct ConverterView: View {
    @State private(set) var backgroundColor: Color = .white
    @State private(set) var hexColor: String = "FFFFFF"
    @State private(set) var rgbColor: String = "255,255,255"
    
    var body: some View {
        ZStack {
            backgroundColor
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
                                rgbColor = hexToRGB(hex: "#" + newValue)
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
                            var rgbArray = newValue.components(separatedBy: ",")
                                                  .prefix(3)
                                                  .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
                            if rgbArray.count == 3, rgbArray.allSatisfy({ 0...255 ~= $0 })
                         {
                                backgroundColor = Color(hex: "#" + rgbToHex(r: rgbArray[0], g: rgbArray[1], b: rgbArray[2]))
                                hexColor = rgbToHex(r: rgbArray[0], g: rgbArray[1], b: rgbArray[2])
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
                
                Spacer().frame(height: 50)
                
                Rectangle()
                    .stroke(Color.System.systemBlack, lineWidth: 5)
                    .frame(height: 200)
                    .overlay {
                        Text("설명")
                    }
                    .padding([.leading, .trailing], 100)
            }
            .padding()
        }
        .ignoresSafeArea()
        .navigationTitle(Text("Color Converter"))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    // TODO: Sheet 등장하며 hex랑 RGB 간의 관계 정의하도록 하기
                }, label: {
                    Image(systemName: "questionmark.circle").fontWeight(.bold)
                })
            }
        })
    }
    
    // HEX ➡️ RGB
    func hexToRGB(hex: String) -> String {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Int((rgb >> 16) & 0xFF)
        let g = Int((rgb >>  8) & 0xFF)
        let b = Int((rgb >>  0) & 0xFF)
        
        return "\(r), \(g), \(b)"
    }
    
    // RGB ➡️ HEX
    func rgbToHex(r: Int, g: Int, b: Int) -> String {
        let hexString = String(format: "%02x%02x%02x", r, g, b)
        return hexString
    }
}

