import SwiftUI
import PhotosUI

// MARK: - TODO
/* 1.추가, (편집+삭제)삭제 버튼 hidden여부 2가지 모드로 쓰여야 함
   3. 칸이 다 채워지지 않았다면 알람 등장하도록 할 것 */
struct MemoryFormView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MemoryViewModel
    
    @State private var memoryToEdit: Memory?
    @State private(set) var navigationTitle = "Create a New Memory"
    @State private(set) var buttonText = "Create"
    
    @State private(set) var selectedItem: [PhotosPickerItem] = []
    @State private(set)var memoryPicture: Data? = nil
    @State private(set) var memoryTitle: String = ""
    @State private(set) var memoryDate: Date = Date()
    @State private(set) var memoryReflection: String = ""
    
    @State private(set) var showAlert: Bool = false
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    var body: some View {
        VStack {
            // MARK: - Form
            Form {
                // SECTION 1
                Section {
                    PhotosPicker(selection: self.$selectedItem, maxSelectionCount: 1, matching: .images) {
                        showPicture
                            .accessibilityLabel(Text("PhotosPicker"))
                    }
                }  header: {
                    Text("A Piece of Memory")
                }
                
                // SECTION 2
                Section {
                    TextField("Title", text: self.$memoryTitle)
                    DatePicker("Date", 
                               selection: self.$memoryDate,
                               in: ...Date(), displayedComponents: .date)
                        //.environment(\.timeZone, TimeZone.current)
//                    Text("\(memoryDate)")
                }  header: {
                    Text("Basic Information")
                }
                
                // SECTION 3
                Section {
                    TextEditor(text: $memoryReflection)
                        .frame(height: 200)
                        .border(Color.Text.text50, width: 1)
                }  header: {
                    Text("Reflection")
                }
            }
            
            Text(showAlert ? "모든 필드" : "")
            
            // MARK: - Button
            Button {
                if self.memoryToEdit == nil {
                    self.viewModel.didTapMakeMemory(memory: Memory(id: UUID(), picture: memoryPicture, title: memoryTitle, date: Date(), reflection: memoryReflection))
                } else {
                    guard let memoryToEditId = memoryToEdit?.id else {return}
                    self.viewModel.updateMemory(Memory(id: memoryToEditId, picture: memoryPicture, title: memoryTitle, date: memoryDate, reflection: memoryReflection))
                }
                viewModel.memoryToEdit = nil
                viewModel.fetchAllMemories()
                self.dismiss()
            } label: {
                Text(buttonText)
                    .frame(maxWidth: .infinity, minHeight: 20)
            }
            .blackButton()
            .disabled(showAlert == true)
            .padding(30)
        }
        .navigationTitle(navigationTitle)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.memoryToEdit = nil
                    self.dismiss()
                } label: {
                    Text("Cancel")
                }
            }
        })
        .onChange(of: self.selectedItem) { newValue in
            for value in newValue {
                let _ = self.loadTransferable(from: value)
            }
        }
        .onAppear {
            guard let memoryToEdit = viewModel.memoryToEdit else {return}
            self.memoryToEdit = memoryToEdit
            if self.memoryToEdit != nil {
                navigationTitle = "Edit the Memory"
                buttonText = "Editing Completed"
                
                memoryPicture = memoryToEdit.picture
                memoryTitle = memoryToEdit.title
                memoryDate = memoryToEdit.date
                memoryReflection = memoryToEdit.reflection
            }
        }
        .onDisappear {
            self.memoryToEdit = nil
        }
    }
    
    // Loads a `Transferable` object using a representation of the item by matching content types.
    /// The representation corresponding to the first matching content type of the item will be used.
    /// If multiple encodings are available for the matched content type, the preferred item encoding provided to the Photos picker decides which encoding to use.
    /// An error will be thrown if the `Transferable` object doesn't support any of the supported content types of the item.
    ///
    func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == imageSelection else { return }
                switch result {
                case .success(let data?):
                    self.memoryPicture = data
                case .success(nil):
                    Log.e("Loaded the Image but no value, it's empty")
                    break
                case .failure(_):
                    Log.e("Failed")
                    break
                }
            }
        }
    }
    
    // MARK: showPicture
    var showPicture: some View {
        Group{
            if let memoryPicture = memoryPicture, let memoryImage = UIImage(data: memoryPicture){
                Image(uiImage: memoryImage)
                    .resizable()
                     .scaledToFill()
                     .frame(height: 200, alignment: .center)
                     .clipShape(RoundedRectangle(cornerRadius: 10))
                     .frame(maxWidth: .infinity, maxHeight: 250, alignment: .center)
            } else {
                Rectangle()
                    .frame(height: 200, alignment: .center)
                    .cornerRadius(10)
                    .foregroundColor(.clear)
                    .overlay(alignment: .center) {
                        Image(systemName: "person.crop.rectangle.badge.plus")
                            .font(.title)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 250, alignment: .center)
            }
        }
    }
}
