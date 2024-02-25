
import SwiftUI

struct MemoryDetailedView: View {
    @ObservedObject var viewModel = MemoryViewModel()
    @State var dateString = ""
    let memory: Memory
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // HH:mm
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    var body: some View {
        ZStack {
            Color.Text.text30.ignoresSafeArea()
            VStack(spacing: 10) {
                // Section1
                ZStack{
                    Rectangle().frame(height: 80).foregroundStyle(.white)
                    HStack {
                        Text(memory.title)
                            .font(.largeTitle)
                            .foregroundStyle(Color.black).bold()
                        Spacer()
                        Text(dateString)
                            .font(.callout)
                            .foregroundStyle(Color.black)
                    }
                    .padding([.leading, .trailing], 30)
                }
                
                // Section2
                ZStack {
                    Rectangle().frame(height: 400).foregroundStyle(.white)
                    if let picture = memory.picture, let pictureImage = UIImage(data: picture) {
                        Image(uiImage: pictureImage)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 350, height: 350)
                            .clipped()
                    } else {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.Text.text90)
                                .aspectRatio(1, contentMode: .fit)
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .foregroundColor(.Main.main10)
                        }
                    }
                }
                
                // Section3
                ZStack{
                    Rectangle().frame(height: 350).foregroundStyle(.white)
                    Text(memory.reflection)
                    
                }
                Spacer()
            }
            
        }
        .onAppear {
            dateString = MemoryDetailedView.dateFormatter.string(for: memory.date) ?? ""
        }
    }
}



