import SwiftUI

struct BorradorTarjetaView: View {
    @Environment(AppEstado.self) var estado

    func filaDocumento(titulo: LocalizedStringKey, detalle: LocalizedStringKey, listo: Bool) -> some View {
        HStack {
            Image(systemName: listo ? "checkmark.seal" : "pencil.and.list.clipboard")
                .foregroundStyle(listo ? Color.colorverde : Color.orange)
            VStack(alignment: .leading) {
                Text(titulo)
                    .font(.caption.weight(.semibold))
                Text(detalle)
                    .font(.caption2)
                    .foregroundStyle(listo ? Color.gray : Color.orange)
            }
            Spacer()
            Image(systemName: listo ? "eye" : "pencil")
                .foregroundStyle(Color.gray)
        }
        .padding(12)
        .background(listo ? Color.colorfondo : Color.colorambarclaro)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Image(systemName: "folder")
                    .foregroundStyle(Color.colorazul)
                    .frame(width: 32, height: 32)
                    .background(Color.colorazulclaro)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                VStack(alignment: .leading) {
                    Text("Borrador rápido de postulación")
                        .font(.headline)
                    Text("Expediente centralizado para postulaciones")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                }
                Spacer()
                NavigationLink(destination: DatosAcademicosView()) {
                    Text("Editar")
                        .font(.caption.weight(.semibold))
                }
            }

            filaDocumento(titulo: "Kardex", detalle: estado.kardexNombre == "" ? "Pendiente (obligatorio)" : "\(estado.kardexNombre)", listo: estado.kardexNombre != "")
            filaDocumento(titulo: "CV", detalle: estado.cvNombre == "" ? "Pendiente (obligatorio)" : "\(estado.cvNombre)", listo: estado.cvNombre != "")
            filaDocumento(titulo: "Cartas de recomendación", detalle: estado.cartasNombre == "" ? "Opcional" : "\(estado.cartasNombre)", listo: estado.cartasNombre != "")
        }
        .modifier(TarjetaViewModifier())
    }
}

#Preview {
    NavigationStack {
        BorradorTarjetaView()
            .padding()
            .background(Color.colorfondo)
    }
    .environment(AppEstado())
}
