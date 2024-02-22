import SwiftUI

// TODO: HEX, RGB 관련 짧은 지식 넣어주기
struct ConverterView: View {
    @State private(set) var backgroundColor: Color = .white
    @State private(set) var hexColor: String = ""
    @State private(set) var rgbColor: String = ""
    
    var body: some View {
        ZStack {
            backgroundColor
            VStack(spacing: 30) {
                
                // HEX
                HStack(spacing: 10) {
                    Image(systemName: "number").font(.title2).bold()
                    TextField("HEX", text: self.$hexColor) 
                        .font(.title2).bold()
                        .padding([.leading, .trailing], 30)
                        .frame(width: 600, height: 50)
                        .onChange(of: hexColor) { newValue in
                            backgroundColor = Color(hex: hexColor)
                            if newValue.count == 6 {
                                rgbColor = hexToRGB(hex: "#" + newValue)
                            }
                        }
                }
                .padding()
                .background(.clear)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.System.systemBlack, lineWidth: 5)
                )
                
                // RGB
                HStack(spacing: 10) {
                    Image(systemName: "paintbrush").font(.title2).bold()
                    TextField("RGB", text: self.$rgbColor) //#달려야 함
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
                .background(.clear)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.System.systemBlack, lineWidth: 5)
                )
                Spacer().frame(height: 200)
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
        let hexString = String(format: "%02X%02X%02X", r, g, b)
        return hexString
    }
}

