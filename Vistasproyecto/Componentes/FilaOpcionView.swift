import SwiftUI

struct FilaOpcionView: View {
    var icono: String
    var titulo: LocalizedStringKey
    var subtitulo: LocalizedStringKey
    var etiqueta: String = ""
    var colorEtiqueta: Color = Color.colorverde
    var fondoEtiqueta: Color = Color.colorverdeclaro

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icono)
                .foregroundStyle(Color.colorazul)
                .frame(width: 32, height: 32)
                .background(Color.colorazulclaro)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(titulo)
                        .font(.subheadline.weight(.semibold))
                    if etiqueta != "" {
                        EtiquetaView(texto: LocalizedStringKey(etiqueta), colorTexto: colorEtiqueta, colorFondo: fondoEtiqueta)
                    }
                }
                Text(subtitulo)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.gray)
        }
        .padding(12)
    }
}

#Preview {
    VStack(spacing: 0) {
        FilaOpcionView(icono: "graduationcap", titulo: "Datos Universitarios y Promedio", subtitulo: "IEST · Licenciatura · 9.2 GPA")
        FilaOpcionView(icono: "folder", titulo: "Documentos y Kardex Oficial", subtitulo: "Kardex, CV Europass, Cartas", etiqueta: "3 listos")
    }
    .background(Color.colortarjeta)
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .padding()
    .background(Color.colorfondo)
}
