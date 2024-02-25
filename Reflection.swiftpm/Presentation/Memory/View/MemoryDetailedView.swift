
import SwiftUI

struct MemoryDetailedView: View {
    @ObservedObject var viewModel = MemoryViewModel()
    @State var dateString = ""
 
    let memory: Memory
    let colorChip: ColorChip
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // HH:mm
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                Color(hex: colorChip.colorList)
                VStack(spacing:0) {
                    Spacer().frame(height: 20)
                    
                    // Section1
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 400)
                            .border(Color.black, width: 0.5)
                        if let picture = memory.picture, let pictureImage = UIImage(data: picture) {
                            Image(uiImage: pictureImage)
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(width: 350, height: 350)
                                .clipped()
                                .accessibilityLabel(Text(memory.title))
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
                                    .accessibilityLabel("Photo")
                            }
                        }
                    }
                    
                    // Section2
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 100)
                            .border(Color.black, width: 0.5)
              
                        VStack {
                            Text(memory.title)
                                .font(.largeTitle)
                                .foregroundStyle(Color.black).bold()
                            
                            Text(dateString)
                                .font(.callout)
                                .foregroundStyle(Color.black)
                        }
                        .padding([.leading, .trailing], 30)
                    }
                    
                    // Section3
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                        Text(memory.reflection).font(.body).padding()
                    }
                    .border(Color.black, width: 0.5)
                    //.padding()
            
                }
                .padding([.leading, .trailing], 200)
                .padding([.top, .bottom], 40)
                Spacer().frame(height: 40)
            }
            .onAppear {
                dateString = MemoryDetailedView.dateFormatter.string(for: memory.date) ?? ""
            }
        }
    }
}



