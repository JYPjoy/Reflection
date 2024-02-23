import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                RainbowWheel()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
