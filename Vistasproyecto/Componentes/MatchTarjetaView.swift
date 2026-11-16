import SwiftUI

struct MatchTarjetaView: View {
    var match: MatchModel
    var leida: Bool = false
    var alAccion: () -> Void = {}
    var destacada: Bool? = nil

    var verde: Bool { destacada ?? (match.id == 1) }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                if !leida {
                    Circle()
                        .fill(Color.colorrojo)
                        .frame(width: 8, height: 8)
                }
                EtiquetaView(texto: LocalizedStringKey(match.etiqueta),
                             colorTexto: verde ? Color.colorverde : Color.colorazul,
                             colorFondo: verde ? Color.colorverdeclaro : Color.colorazulclaro)
                Text(LocalizedStringKey(match.detalle))
                    .font(.caption2)
                    .foregroundStyle(Color.gray)
                Spacer()
                Text(LocalizedStringKey(match.cuando))
                    .font(.caption2)
                    .foregroundStyle(Color.gray)
            }
            Text(LocalizedStringKey(match.titulo))
                .font(.headline)
            Text(LocalizedStringKey(match.descripcion))
                .font(.caption)
                .foregroundStyle(Color.gray)
            HStack {
                Text(LocalizedStringKey(match.pie))
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(verde ? Color.colorverde : Color.gray)
                Spacer()
                Button(action: {
                    alAccion()
                }) {
                    Label(LocalizedStringKey(match.accion), systemImage: "arrow.right")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.colorazulclaro)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .modifier(TarjetaViewModifier())
    }
}

#Preview {
    MatchTarjetaView(match: BecaViewModel().getMatches()[0])
        .padding()
        .background(Color.colorfondo)
}
