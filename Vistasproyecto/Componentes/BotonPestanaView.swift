import SwiftUI

struct BotonPestanaView: View {
    var texto: LocalizedStringKey
    var seleccionado: Bool
    var accion: () -> Void

    var body: some View {
        Button(action: accion) {
            Text(texto)
                .font(.caption.weight(.semibold))
                .foregroundStyle(seleccionado ? Color.colorazul : Color.primary)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(seleccionado ? Color.colortarjeta : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    HStack(spacing: 0) {
        BotonPestanaView(texto: "Todas", seleccionado: true) {}
        BotonPestanaView(texto: "Matches", seleccionado: false) {}
    }
    .padding(4)
    .background(Color.colorazulclaro)
}
