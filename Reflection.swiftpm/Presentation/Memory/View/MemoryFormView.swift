import SwiftUI

struct MemoryFormView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MemoryViewModel
    
    var body: some View {
        Button {
            self.viewModel.didTapMakeMemory(memory: Memory(id: UUID(), title: "난니", reflection: "어제 구름을 보았다. 몽글몽글한 구름"))
            self.viewModel.fetchAllMemories()
            self.dismiss()
        } label: {
            Text("버튼")
                .frame(maxWidth: .infinity, minHeight: 20)
        }
        .blackButton()
        .padding(30)
    }
}
