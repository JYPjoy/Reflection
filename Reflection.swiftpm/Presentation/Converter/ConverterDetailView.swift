import SwiftUI

struct ConverterDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.Text.text30.ignoresSafeArea()
            VStack(spacing: 30) {
                HStack {
                    Spacer()
                    Button {
                        self.dismiss()
                    } label: {
                        Text("cancel")
                    }
                }
                .padding()
                
                Text("About RGB and Hex").font(.title).bold()
                
                Text("\"RGB\" defines the values of red(first number), green(second number), or blue(third number). The number 0 signifies no representation of the color and 255 signifies the highest possible concentration of the color. For example, white is represented as 255, 255, 255. And black is represented as 0, 0, 0.\n\n\"Hex\" color codes start with a hashtag (#) and are followed by six letters and numbers. The first two refer to red, the next two refer to green, and the last two refer to blue. The color values are defined in values between 00 and FF. For example, white is represented as #ffffff, and black is represented as #000000.")
                Spacer()
            }
            .padding(20)
   
        }
    }
}
