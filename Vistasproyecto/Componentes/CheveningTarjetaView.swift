import SwiftUI

struct CheveningTarjetaView: View {
    @Environment(AppEstado.self) var estado
    @AppStorage("recordatorio-2") var recordatorio = true
    let beca = BecaViewModel().getBecas()[1]
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            EncabezadoBecaView(siglas: beca.siglas, institucion: beca.institucion.uppercased(), titulo: beca.titulo,
                               guardada: estado.estaGuardada(beca), alGuardar: { estado.alternarGuardada(beca) })

            HStack {
                EtiquetaView(texto: "\(beca.compatibilidad)% Compatible", icono: "circle.fill", colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                EtiquetaView(texto: "Cierra en \(beca.diasParaCierre) días", icono: "calendar", colorTexto: Color.orange, colorFondo: Color.colorambarclaro)
            }
            EtiquetaView(texto: LocalizedStringKey(beca.pais))

            HStack {
                Image(systemName: "alarm")
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

            VStack(alignment: .leading, spacing: 6) {
                Label("Requisitos prioritarios pendientes", systemImage: "exclamationmark.triangle")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.orange)
                Label("Falta carta de recomendación académica firmada", systemImage: "exclamationmark.circle")
                    .foregroundStyle(Color.colorrojo)
                Label("Validación de pasaporte y visa previa completa", systemImage: "checkmark.circle")
                    .foregroundStyle(Color.colorverde)
            }
            .font(.caption)
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.colorambarclaro)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Divider()

            HStack {
                VStack(alignment: .leading) {
                    Text("Cobertura")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                    Text("£30,000 + Vuelos")
                        .font(.title3.weight(.bold))
                        .foregroundStyle(Color.colorverde)
                }
                Spacer()
                NavigationLink(destination: BecaDetalleView(beca: beca)) {
                    Label("Ver detalles y enlaces", systemImage: "arrow.up.right.square")
                        .font(.subheadline.weight(.semibold))
                        .padding(12)
                        .background(Color.colorazulclaro)
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
        CheveningTarjetaView()
            .padding()
            .background(Color.colorfondo)
    }
    .environment(AppEstado())
}
