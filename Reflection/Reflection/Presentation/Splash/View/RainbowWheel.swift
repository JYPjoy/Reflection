import SwiftUI

struct RainbowWheel: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            Color.System.systemBlack.ignoresSafeArea()
            VStack {
                Spacer()
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 80, dash: [30]))
                    .fill(AngularGradient(colors: [.red, .green, .blue], center: .center))
                    .padding(50)
                    .rotationEffect(.degrees(rotation))
                    .animation(.linear(duration: 5).speed(0.5)
                               , value: rotation)
                    .onAppear{rotation = 180}
                Spacer()
            }
            
            // Typo 효과
            Text("REFLECTION")
                .font(.title)
                .bold()
                .foregroundStyle(Color.white)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Splash View")
    }
}
