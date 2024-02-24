
import SwiftUI

struct MemoryDetailedView: View {
    @ObservedObject var viewModel = MemoryViewModel()
    @State private var detailedMemory: Memory?
    let memory: Memory
    
    var body: some View {
        Group{
            ScrollView{
                HStack {
                    Text("메모리디테일")
                    Text("메모리디테일")
                }
            }
        }
    }
}

