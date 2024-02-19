import SwiftUI

// TODO: 버튼 비활성화, 더 친절한 form이 되도록 안내 문구 함께 나오도록 하기
// 컴포넌트 크기 조정 필요
struct CreateColorChipView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var createColorViewModel = CreateColorChipViewModel()
    
    @State private var colorName: String = ""
    @State private var colorList: Color = Color(hex: "#F8D749")
    @State private var colorListText: [String] = [] //데이터 저장 시 사용해야 함
    
    var colorChip: ColorChipEntity? = nil
    
    var body: some View {
        VStack {
            // MARK: - Form
            Form {
                // SECTION 1
                Section {
                    TextField("Color Name", text: self.$colorName)
                } header: { // 커스텀화 가능 .font(.body).bold()
                    Text("Color Name")
                }
                
                // SECTION 2
                Section {
                    ColorPicker("Selected Color", selection: self.$colorList, supportsOpacity: false)
                } header: { Text("Select the color") }
            }
            
            // MARK: - Button
            Button {
                createColorViewModel.didTapMakeColorChip(colorChip: ColorChip(id: UUID(), colorName: colorName, colorList: colorList.HexToString() ?? "#F8D749", memories: []))
                
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
        .onAppear(perform: {
            if let colorChip = self.colorChip {
                self.colorName = colorChip.colorName
                self.colorList = Color(hex: colorChip.colorList)
            }
        })
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    self.dismiss()
                } label: {
                    Text("Cancel")
                }
            }
        })
    }
}
