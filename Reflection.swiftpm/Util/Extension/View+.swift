import SwiftUI

extension View {
    // MARK: - Label Color 기준
    func blackLabel() -> some View {
        return self
            .modifier(BlackTextViewModifier())
    }
    
    func whiteLabel() -> some View {
        return self
            .modifier(WhiteTextViewModifier())
    }
    
    func grayLabel() -> some View {
        return self
            .modifier(GrayTextViewModifier())
    }
    
    // MARK: - button 배경 색깔 기준
    func mainButton() -> some View {
        return self
            .modifier(BlackTextViewModifier())
            .modifier(
                ButtonViewModifier(
                    border: Color(.main50),
                    background: Color(.main50)
                )
            )
    }
    
    func blackButton() -> some View {
        return self
            .modifier(WhiteTextViewModifier())
            .modifier(
                ButtonViewModifier(
                    border: Color(.systemBlack),
                    background: Color(.systemBlack)
                )
            )
    }
    
    func grayButton() -> some View {
        return self
            .modifier(GrayTextViewModifier())
            .modifier(
                ButtonViewModifier(
                    border: Color(.text50),
                    background: Color(.text30)
                )
            )
    }
}
