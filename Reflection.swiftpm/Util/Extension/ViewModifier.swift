import SwiftUI

// MARK: - ViewModifier
struct BlackTextViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body.bold())
            .foregroundColor(.Text.text90)
    }
}

struct WhiteTextViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.Text.text10)
    }
}

struct GrayTextViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body.bold())
            .foregroundColor(.Text.text50)
    }
}

// MARK: - ButtonViewModifier
struct ButtonViewModifier: ViewModifier {
    var border: Color
    var background: Color
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(background)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(border, lineWidth: 1)
            )
    }
}
