import SwiftUI

struct ConverterView: View {
    @Environment(\.dismiss) var dismiss
    @State private(set) var backgroundColor: Color = .white
    @State private(set) var hexColor: String = "FFFFFF"
    @State private(set) var rgbColor: String = "255,255,255"
    @State private(set) var showSheet: Bool = false
    
    var body: some View {
        
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack(spacing: 30) {
                
                // HEX
                HStack(spacing: 10) {
                    Image(systemName: "number")
                        .font(.title2).bold()
                        .accessibilityHidden(true)
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
                        .accessibilityLabel(ColorManager.shared.hexToRGBAccessibility(hex: "#" + hexColor))
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
                    Image(systemName: "paintbrush")
                        .font(.title2).bold()
                        .accessibilityHidden(true)
                    TextField("RGB(ex: 248,215,73)", text: self.$rgbColor)
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
                        .accessibilityLabel(ColorManager.shared.rgbToAccessibility(rgbColor))
                     
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
         
                    Text("When you enter a hex Color(without the #) on first input field, it will automatically convert into RGB on second input field. \nSimilarly, When you enter an RGB color on second input field, it automatically convert into a hex  Color. Just try it!\n\nIf you want to know more about RGB and HEX, then click the Help button on the top right side of toolbar.")
                        .font(.body)
                        .padding(25)
                }
                .padding([.leading, .trailing], 50)
                .frame(height: 200)
            }
            .padding()
        }
        .navigationTitle(Text("Color Converter"))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.showSheet.toggle()
                }, label: {
                    Image(systemName: "questionmark.circle").fontWeight(.bold)
                        .accessibilityLabel("Help")
                })
            }
        })
        .sheet(isPresented: self.$showSheet) {
            NavigationStack {
                ConverterDetailView()
            }
        }
    }
}
