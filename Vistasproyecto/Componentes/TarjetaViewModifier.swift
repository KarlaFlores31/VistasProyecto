import SwiftUI

struct TarjetaViewModifier: ViewModifier {
    var colorFondo: Color = Color.colortarjeta
    var colorBorde: Color = .gray.opacity(0.2)

    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(colorFondo)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(colorBorde))
    }
}

extension View {
    func anchoMaximo() -> some View {
        self
            .frame(maxWidth: 600)
            .frame(maxWidth: .infinity)
    }
}
