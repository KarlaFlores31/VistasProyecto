import SwiftUI

struct EncabezadoBecaView: View {
    var siglas: String
    var institucion: String
    var titulo: String
    var guardada: Bool = true
    var alGuardar: () -> Void = {}

    var body: some View {
        HStack(alignment: .top) {
            SiglasView(siglas: siglas)
            VStack(alignment: .leading, spacing: 2) {
                Text(institucion)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                Text(titulo)
                    .font(.headline)
            }
            Spacer()
            Button(action: {
                alGuardar()
            }) {
                Image(systemName: guardada ? "bookmark.fill" : "bookmark")
                    .font(.title3)
                    .foregroundStyle(Color.colorazul)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    EncabezadoBecaView(siglas: "FC", institucion: "FUNDACIÓN CAROLINA", titulo: "Máster en Inteligencia Artificial Aplicada")
        .padding()
}
