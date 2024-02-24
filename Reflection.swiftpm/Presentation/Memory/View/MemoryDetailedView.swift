
import SwiftUI

struct MemoryDetailedView: View {
    let memory: Memory
    
    var body: some View {
        Group{
            ScrollView{
            
            }
            .padding()
            .padding(.bottom,10)
            
        }
        .onAppear {
            Log.d(memory)
        }
    }
}

