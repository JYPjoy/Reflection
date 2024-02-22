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
                        viewModel.didTapMakeMemory(memory: Memory(id: UUID(), title: "테스트용", date: Date(), reflection: "멋진 뼈다귀"))
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
                        //viewModel.updateMemory(Memory(id: UUID(uuidString: "45D4BDBE-1BDD-48E6-99CF-7C3E37C6B75B")!, title: "멋쟁이 뼈다귀", date: Date(), reflection: "잘 업데이트 되었나요?"))
                    }, label: {
                        Text("업데이트하기(Update)")
                    })
                    .mainButton()
                    Spacer()
                    
                    Button(action: {
                        viewModel.deleteMemory(UUID(uuidString: "31934F94-2862-4B35-9060-7BE5F7132F40")!)
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

