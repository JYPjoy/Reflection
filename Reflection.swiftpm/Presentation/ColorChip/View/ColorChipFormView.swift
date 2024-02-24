import SwiftUI

// TODO: 버튼 비활성화(블랙 회색 색상도), 더 친절한 form이 되도록 안내 문구 함께 나오도록 하기
struct ColorChipFormView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ColorChipViewModel
    
    //현재 뷰 구성 위함
    @State private var colorChipToEdit: ColorChip?
    @State private(set) var navigationTitle = "Create a New Color Chip"
    @State private(set) var buttonText = "Create"
    
    @State private(set) var colorName: String = ""
    @State private(set) var colorList: Color = Color(hex: "#F8D749")

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
                    Text("Selected Color is " + (self.colorList.HexToString() ?? "") )
                } header: { Text("Select the color") }
            }
            
            // MARK: - Button
            Button {
                if self.colorChipToEdit == nil  { //Create
                    viewModel.didTapMakeColorChip(colorChip: ColorChip(id: UUID(), colorName: colorName, colorList: colorList.HexToString() ?? "#F8D749", memories: []))
                } else { // Update
                    guard let colorChipToEditId = colorChipToEdit?.id else {return}
                    viewModel.updateColorChip(ColorChip(id: colorChipToEditId, colorName: colorName, colorList: colorList.HexToString() ?? "#F8D749", memories: []))
                }
                viewModel.fetchAllColorChips()
                self.dismiss()
            } label: {
                    Text(buttonText)
                    .frame(maxWidth: .infinity, minHeight: 20)
       
            }
            .disabled(colorName.isEmpty)
            .blackButton()
            .padding(30)
        }
        .onAppear {
            guard let colorChipToEdit = viewModel.colorChipToEdit else { return }
            self.colorChipToEdit = colorChipToEdit
            
            if self.colorChipToEdit != nil {
                navigationTitle = "Edit the Color Chip"
                buttonText = "Editing Completed"
                colorName = colorChipToEdit.colorName
                colorList = Color(hex:colorChipToEdit.colorList)
            }
        }
        .onDisappear(perform: {
            colorChipToEdit = nil
        })
        .navigationTitle(navigationTitle)
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
