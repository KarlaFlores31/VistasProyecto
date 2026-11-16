import SwiftUI

struct CarolinaTarjetaView: View {
    @Environment(AppEstado.self) var estado
    @AppStorage("recordatorio-1") var recordatorio = true
    let beca = BecaViewModel().getBecas()[0]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            EncabezadoBecaView(siglas: beca.siglas, institucion: beca.institucion.uppercased(), titulo: beca.titulo,
                               guardada: estado.estaGuardada(beca), alGuardar: { estado.alternarGuardada(beca) })

            HStack {
                EtiquetaView(texto: "\(beca.compatibilidad)% Compatible", icono: "circle.fill", colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                EtiquetaView(texto: "Cierra en \(beca.diasParaCierre) días", icono: "clock", colorTexto: Color.colorrojo, colorFondo: Color.colorrojoclaro)
            }
            EtiquetaView(texto: LocalizedStringKey(beca.pais))

            HStack {
                Image(systemName: "bell")
                    .foregroundStyle(Color.colorazul)
                    .frame(width: 32, height: 32)
                    .background(Color.colorazulclaro)
                    .clipShape(Circle())
                Toggle(isOn: $recordatorio) {
                    VStack(alignment: .leading) {
                        Text(recordatorio ? "Recordatorio activado" : "Recordatorio desactivado")
                            .font(.subheadline.weight(.medium))
                        Text("Aviso 3 días antes del cierre")
                            .font(.caption)
                            .foregroundStyle(Color.gray)
                    }
                }
                .tint(Color.colorazuloscuro)
                .onChange(of: recordatorio) {
                    if recordatorio {
                        Notificaciones.shared.programarRecordatorio(beca)
                    } else {
                        Notificaciones.shared.cancelarRecordatorio(beca)
                    }
                }
            }
            .padding(12)
            .background(Color.colorfondo)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            HStack {
                Label("Preparación de documentos", systemImage: "checklist")
                    .font(.caption.weight(.semibold))
                Spacer()
                Text("3 de 5 requisitos listos")
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.colorazulclaro)
                    Capsule()
                        .fill(Color.colorazuloscuro)
                        .frame(width: geometry.size.width * 3 / 5)
                }
            }
            .frame(height: 8)
            HStack {
                Label("Título, CV, TOEFL", systemImage: "checkmark.circle")
                    .foregroundStyle(Color.colorverde)
                Label("Falta Ensayo y Kardex", systemImage: "ellipsis.circle")
                    .foregroundStyle(Color.colorrojo)
            }
            .font(.caption2)

            Divider()

            HStack {
                VStack(alignment: .leading) {
                    Text("Financiamiento")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                    Text("100% Dotación")
                        .font(.title3.weight(.bold))
                        .foregroundStyle(Color.colorverde)
                }

                Spacer()
                NavigationLink(destination: BecaDetalleView(beca: beca)) {
                    HStack {
                        Text(estado.postuladas.contains(beca.id) ? "Ver postulación" : "Continuar postulación")
                        Image(systemName: "arrow.right")
                    }
                    .font(.subheadline.weight(.semibold))
                    .padding(12)
                    .background(Color.colorazuloscuro)
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .fixedSize()
            }
        }
        .modifier(TarjetaViewModifier())
    }
}

#Preview {
    NavigationStack {
        CarolinaTarjetaView()
            .padding()
            .background(Color.colorfondo)
    }
    .environment(AppEstado())
}
