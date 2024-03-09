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
                Text("Make your own Color Chip with distinct names on it!")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.System.systemWhite)
                
                Spacer()
            }
            .padding(30)
            .padding(.top, 30)
            
            Image("onboarding1")
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
                Text("Reflect from your memories of the Color, and make your own color language.")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.System.systemWhite)
                
                Spacer()
            }
            .padding(30)
            .padding(.top, 30)
            
            Image("onboarding2")
                .resizable()
                .scaledToFit()
                .frame(width: 600)
                .accessibilityHidden(true)
//            
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
                Text("Can convert Hex colors to RGB colors, and vice versa, in Converter Tab")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.System.systemWhite)
                
                Spacer()
            }
            .padding(30)
            .padding(.top, 30)
            
            Image("onboarding3")
                .resizable()
                .scaledToFit()
                .frame(width: 600)
                .accessibilityHidden(true)
            
            Spacer()
        }
        .onAppear {
            // #1 Lively Green, #dbe1af
            viewModel.didTapMakeColorChip(colorChip: ColorChip(id: UUID(), colorName: "A Lively Green", colorList: "#dbe1af", memories: []))
            viewModel.didTapMakeMemory(memory: Memory(id: UUID(), picture: UIImage(named: "stevejobstheater")?.pngData(), title: "Apple Park's green", date: Date(), reflection: "At WWDC23, I have had a chance to look toward Apple Park in front of Steve Jobs Theater. Apple Park was surrounded by various grasses and trees. It was so fabulous!  That green color reminds me of ‘Saint-Saens: Carnival of the Animals-Finale’. I felt so cheerful, and full of joy."))
            
            
            // #(2) FluffyGreen, #409310
            viewModel.didTapMakeColorChip(colorChip: ColorChip(id: UUID(), colorName: "FluffyGreen", colorList: "#409310", memories: []))
            
            // #3 ChillyBlue, #074A90
            viewModel.didTapMakeColorChip(colorChip: ColorChip(id: UUID(), colorName: "ChillyBlue", colorList: "#074A90", memories: []))
            viewModel.didTapMakeMemory(memory: Memory(id: UUID(), picture: UIImage(named: "ulleungdo")?.pngData(), title: "Ulleungdo", date: Date(), reflection: "Today I went to Ulleungdo, which is an island located in eastern part of Korea. The weather was windy and the water was so cool. I felt refreshing. I think blue is a feeling of chilly."))
            
            
            // #4 Tickle me Pink, #FC80A5
            viewModel.didTapMakeColorChip(colorChip: ColorChip(id: UUID(), colorName: "Tickle me Pink", colorList: "#FC80A5", memories: []))
            
            // #5 golden-brown sweet potato, #FC80A5
            viewModel.didTapMakeColorChip(colorChip: ColorChip(id: UUID(), colorName: "golden-brown sweet potato", colorList: "#F8D749", memories: []))
        }

    }
    
    var fourthView: some View { 
        
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
                Text("To help your understanding, I added some examples. \nAre you ready to start? Then Let's get started!")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.System.systemWhite)
                
                Spacer()
            }
            .padding(30)
            .padding(.top, 30)
            
            
            Spacer()
        }
    }
}
