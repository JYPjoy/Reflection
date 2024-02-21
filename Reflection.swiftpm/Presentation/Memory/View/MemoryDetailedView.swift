
import SwiftUI

struct MemoryDetailedView: View {
    var body: some View {
        Group{
            ScrollView{
                CompositionalView(items: 1...30, id: \.self) { item in
                    ZStack{
                        Rectangle()
                            .fill(.cyan)
                        
                        Text("\(item)")
                            .font(.title.bold())
                    }
                }
                .padding()
                .padding(.bottom,10)
                
            }
        }
    }
}

