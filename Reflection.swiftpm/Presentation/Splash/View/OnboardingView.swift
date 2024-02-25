import SwiftUI

struct OnboardingView: View {
    
    @Binding var currentView: Int
    @ObservedObject var viewModel: OnboardingViewModel
    
    
    var body: some View {
        ZStack {
            VStack {
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
                            Log.d("객체 생성")
                        }
                    }

                } label: {
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                }
                .mainButton()
            }
        }
    }
    
    var firstView: some View { //컬러칩
        Text("하이1")
    }
        
    var secondView: some View { //메모리
        Text("하이2")
    }
    
    var thirdView: some View { //상세 메모리
        Text("하이3")
    }
    
    var fourthView: some View { //컨버터
        Text("하이4")
    }
}
