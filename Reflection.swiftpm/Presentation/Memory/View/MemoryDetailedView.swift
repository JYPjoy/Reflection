
import SwiftUI

struct MemoryDetailedView: View {
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
        .onAppear {
            Log.d(memory)
        }
    }
}

