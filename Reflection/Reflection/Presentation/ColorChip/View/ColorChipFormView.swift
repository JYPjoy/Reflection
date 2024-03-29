import SwiftUI

struct ColorChipFormView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ColorChipViewModel
    
    //현재 뷰 구성 위함
    @State private var colorChipToEdit: ColorChip?
    @State private(set) var navigationTitle = "Create a New Color Chip"
    @State private(set) var buttonText = "Create"
    
    @State private(set) var colorName: String = ""
    @State private(set) var colorList: Color = Color(hex: "#F8D749")
    
    var isValidateForm: Bool {
        !colorName.isEmpty
    }

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
                        .accessibility(label: Text("Color Picker"))
                    Text("Selected Color is " + (self.colorList.HexToString() ?? "") )
                        .accessibilityLabel("Selected Color is" + ColorManager.shared.hexToRGBAccessibility(hex: (self.colorList.HexToString() ?? "")))
                        
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
                viewModel.colorChipToEdit = nil
                viewModel.fetchAllColorChips()
                self.dismiss()
            } label: {
                    Text(buttonText)
                    .frame(maxWidth: .infinity, minHeight: 20)
       
            }
            .blackButton()
            .opacity(isValidateForm ? 1 : 0.5)
            .disabled(!isValidateForm)
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
                    viewModel.colorChipToEdit = nil
                    self.dismiss()
                } label: {
                    Text("Cancel")
                }
            }
        })
    }
}
