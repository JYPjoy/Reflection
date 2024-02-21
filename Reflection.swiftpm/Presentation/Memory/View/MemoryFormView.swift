import SwiftUI

struct MemoryFormView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MemoryViewModel
    
    var body: some View {
        Button {
            
            self.dismiss()
        } label: {
            Text("버튼")
                .frame(maxWidth: .infinity, minHeight: 20)
        }
        .blackButton()
        .padding(30)
    }
}
