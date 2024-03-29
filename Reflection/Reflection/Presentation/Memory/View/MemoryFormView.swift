import SwiftUI
import PhotosUI

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
    
    var isValidateForm: Bool {
        !memoryTitle.isEmpty && !memoryReflection.isEmpty
    }
    
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
                    //Text(formattedDate(memoryDate)) //TODO: 이 내용 지워야 함
                        //.environment(\.timeZone, TimeZone.current)
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
            
            // MARK: - Button
            Button {
                if self.memoryToEdit == nil {
                    self.viewModel.didTapMakeMemory(memory: Memory(id: UUID(), picture: memoryPicture, title: memoryTitle, date: memoryDate, reflection: memoryReflection))
                } else {
                    Log.d(memoryDate)
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
            .opacity(isValidateForm ? 1 : 0.5)
            .disabled(!isValidateForm)
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
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
