import SwiftUI

struct OnboardingView: View {
    
    @Binding var currentView: Int
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            Color.System.systemBlack
            VStack(spacing: 20) {
                switch self.currentView {
                case 0: firstView
                case 1: secondView
                case 2: thirdView
                case 3: fourthView
                default: ContentView()
                }
                
                Button {
                    withAnimation {
                        if (currentView <= 3 && currentView != 3) {
                            currentView += 1
                        } else { //3
                            currentView += 1
                        }
                    }
                } label: {
                    Text("Next")
                        .frame(maxWidth: .infinity, minHeight: 20)
                        .font(.title2)
                }
                .mainButton()
                .font(.title)
                .padding([.leading, .trailing], 50)
                .padding([.bottom], 100)
                
            }
        }
    }
    
    var firstView: some View { //컬러칩
        VStack(spacing: 20){
            HStack {
                Text("Make your own Color Chip")
                    .bold()
                    .font(.title)
                    .foregroundColor(.System.systemWhite)
                
                Spacer()
            }
            .padding(30)
            .padding(.top, 30)
            
            
            HStack {
                Text("Build your own Color Chip with distinct names on it!")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.System.systemWhite)
                
                Spacer()
            }
            .padding(30)
            .padding(.top, 30)
            
            Image("rainbow")
                .resizable()
                .scaledToFit()
                .frame(width: 600)
                .accessibilityHidden(true)
            
            Spacer()
        }
    }

        
    var secondView: some View { //메모리 + 상세 메모리
        VStack(spacing: 20){
            HStack {
                Text("Reflect from your memories")
                    .bold()
                    .font(.title)
                    .foregroundColor(.System.systemWhite)
                
                Spacer()
            }
            .padding(30)
            .padding(.top, 30)
            
            
            HStack {
                Text("Reflect from your memories of the Color, and Make your own schema(a cognitive framework organizes and interprets information in the human mind.).") //스키마 풀어 쓰기
                    .bold()
                    .font(.title2)
                    .foregroundColor(.System.systemWhite)
                
                Spacer()
            }
            .padding(30)
            .padding(.top, 30)
            
            Image("stevejobstheater")
                .resizable()
                .scaledToFit()
                .frame(width: 600)
                .accessibilityHidden(true)
            
            Spacer()
        }
         
    }
    
    var thirdView: some View { // 컨버터
        
        VStack(spacing: 20){
            HStack {
                Text("Color Converter")
                    .bold()
                    .font(.title)
                    .foregroundColor(.System.systemWhite)
                
                Spacer()
            }
            .padding(30)
            .padding(.top, 30)
            
            
            HStack {
                Text("Reflect from your memories of the Color, and Make your own color language")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.System.systemWhite)
                
                Spacer()
            }
            .padding(30)
            .padding(.top, 30)
            
            Image("rainbow")
                .resizable()
                .scaledToFit()
                .frame(width: 600)
                .accessibilityHidden(true)
            
            Spacer()
        }
        .onAppear {
            // #1 Lively Green, #dfe772
            /* 스티브잡스 씨어터 - 청각: 생상스 - The Carnival of the Animals - Finale,
                아보카도 - 부드러운 맛(촉각)
             */
            viewModel.didTapMakeColorChip(colorChip: ColorChip(id: UUID(), colorName: "테스트", colorList: "#dfe772", memories: [Memory(id: UUID(), title: "하이", date: Date(), reflection: "하이")]))
            
            // The Carnival of the Animals - Finale
            viewModel.didTapMakeMemory(memory: Memory(id: UUID(), picture: UIImage(named: "rainbow")?.pngData(), title: "타이틀", date: Date(), reflection: "감상"))
            
            
            // #(2) FluffyGreen, #409310
            /* 레인보우 브릿지 - 촉각, 시각 (거대한 초록 빛의 카펫 - 폭신폭신)
             */
            
            // #3 ChillyBlue, #074A90
            /*
             이카루스 : Tactile Masterpiece Exhibition
             울릉도: Ulleung_island
             */
            
            
            // #4 Tickle me Pink, #FC80A5
            
            // #5 golden-brown sweet potato, #FC80A5
            
        }

    }
    
    var fourthView: some View { //example 넣었다, 어떤 환경에서 구동? (12.9)
        
        VStack(spacing: 20){
            HStack {
                Text("Let's get started!")
                    .bold()
                    .font(.title)
                    .foregroundColor(.System.systemWhite)
                
                Spacer()
            }
            .padding(30)
            .padding(.top, 30)
            
            
            HStack {
                Text("Please view this on an iPad Pro 12.9 device. To help your understanding, I added some examples. \nAre you ready to start? Then Let's get started!")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.System.systemWhite)
                
                Spacer()
            }
            .padding(30)
            .padding(.top, 30)
            
            Image("rainbow")
                .resizable()
                .scaledToFit()
                .frame(width: 600)
                .accessibilityHidden(true)
            
            Spacer()
        }
    }
}
