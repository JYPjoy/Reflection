import SwiftUI

struct MemoryOverView: View {
    @ObservedObject var viewModel = MemoryViewModel()
    @State private var createNewMemory = false
    let colorChip: ColorChip
    
    var body: some View {
        Group{
            ScrollView{
                VStack(spacing: 30) {
                    Button(action: {
                        viewModel.didTapMakeMemory(memory: Memory(id: UUID(), title: "테스트용", reflection: "멋진 뼈다귀"))
                    }, label: {
                        Text("추가하기(Create)")
                    })
                    .blackButton()
                    Spacer()
                    
                    
                    Button(action: {
                        viewModel.fetchAllMemories()
                        viewModel.fetchSpecificColorChip()
                    }, label: {
                        Text("메모리 내용 출력하기(read)")
                    })
                    .mainButton()
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("업데이트하기(Update)")
                    })
                    .mainButton()
                    Spacer()
                    
                    Button(action: {
                        viewModel.deleteMemory(UUID(uuidString: "8121ED9E-8096-4A83-9CCB-2DBF45CC0297")!)
                    }, label: {
                        Text("삭제하기(Delete)")
                    })
                    .blackButton()
                }

//                CompositionalView(items: 1...30, id: \.self) { item in
//                    ZStack{
//                        Rectangle()
//                            .fill(.cyan)
//                        
//                        Text("\(item)")
//                            .font(.title.bold())
//                    }
//                }
//                .padding()
//                .padding(.bottom,10)
                
            }
        }
        .navigationTitle(Text("Memories of " + colorChip.colorName))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.createNewMemory.toggle()
                }, label: {
                    Image(systemName: "plus").fontWeight(.bold)
                    Text("Add new Memory")
                })
            }
        })
        .sheet(isPresented: self.$createNewMemory) {
            NavigationStack {
                MemoryFormView(viewModel: viewModel)
            }
        }
        .onAppear(perform: {
            viewModel.specificColorChip = colorChip
        })
    }
}

