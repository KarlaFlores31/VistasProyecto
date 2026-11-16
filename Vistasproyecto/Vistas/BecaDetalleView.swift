import SwiftUI

struct BecaDetalleView: View {
    @Environment(AppEstado.self) var estado
    var beca: BecaModel
    @State var mostrarConfirmacion = false
    @State var confirmarCancelacion = false

    var yaPostulada: Bool {
        estado.postuladas.contains(beca.id)
    }

    @State var cambio: RespuestaTipoCambio?
    @State var cargandoCambio = false
    @State var errorCambio = false

    func cargarCambio() async {
        guard let valor = beca.montoValor, let moneda = beca.moneda else { return }
        cargandoCambio = true
        errorCambio = false
        do {
            cambio = try await TipoCambioAPI.convertir(valor, de: moneda)
        } catch {
            errorCambio = true
        }
        cargandoCambio = false
    }

    func fechaBonita(_ texto: String) -> String {
        if let fecha = try? Date(texto + "T12:00:00Z", strategy: .iso8601) {
            return fecha.formatted(date: .abbreviated, time: .omitted)
        }
        return texto
    }

    var conversionView: some View {
        VStack(alignment: .leading, spacing: 4) {
            if cargandoCambio {
                HStack(spacing: 8) {
                    ProgressView()
                    Text("Consultando tipo de cambio…")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                }
            } else if let cambio = cambio, let pesos = cambio.rates["MXN"] {
                HStack(spacing: 4) {
                    Text("≈")
                    Text(pesos, format: .currency(code: "MXN").precision(.fractionLength(0)))
                    Text("MXN")
                }
                .font(.title3.weight(.bold))
                .foregroundStyle(Color.colorazul)
                Text("Tipo de cambio del \(fechaBonita(cambio.date)) · Frankfurter")
                    .font(.caption2)
                    .foregroundStyle(Color.gray)
            } else if errorCambio {
                HStack {
                    Label("No se pudo obtener el tipo de cambio", systemImage: "wifi.exclamationmark")
                        .font(.caption)
                        .foregroundStyle(Color.colorrojo)
                    Spacer()
                    Button("Reintentar") {
                        Task { await cargarCambio() }
                    }
                    .font(.caption.weight(.semibold))
                }
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.colorazulclaro.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 12) {
                    EncabezadoBecaView(siglas: beca.siglas, institucion: beca.institucion.uppercased(), titulo: beca.titulo,
                                       guardada: estado.estaGuardada(beca),
                                       alGuardar: { estado.alternarGuardada(beca) })
                    HStack {
                        EtiquetaView(texto: "\(beca.compatibilidad)% Compatible", icono: "circle.fill",
                                     colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                        EtiquetaView(texto: LocalizedStringKey(beca.cierre), icono: "clock",
                                     colorTexto: beca.diasParaCierre <= 15 ? Color.colorrojo : Color.gray,
                                     colorFondo: beca.diasParaCierre <= 15 ? Color.colorrojoclaro : Color.gray.opacity(0.1))
                    }
                    HStack {
                        EtiquetaView(texto: LocalizedStringKey(beca.pais), icono: "mappin")
                        EtiquetaView(texto: LocalizedStringKey(beca.nivel), icono: "graduationcap")
                    }
                    EtiquetaView(texto: LocalizedStringKey(beca.area), icono: "books.vertical")
                    Text(beca.descripcion)
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                }
                .modifier(TarjetaViewModifier())

                VStack(alignment: .leading, spacing: 8) {
                    Text("Requisitos")
                        .font(.headline)
                    ForEach(beca.requisitos, id: \.self) { requisito in
                        Label(LocalizedStringKey(requisito), systemImage: "checkmark.circle")
                            .font(.subheadline)
                    }
                    Divider()
                    Label(beca.pie, systemImage: beca.iconoPie)
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                    Label(beca.coberturaTotal ? "Cobertura total" : "Cobertura parcial", systemImage: "banknote")
                        .font(.caption)
                        .foregroundStyle(beca.coberturaTotal ? Color.colorverde : Color.gray)
                }
                .modifier(TarjetaViewModifier())

                VStack(alignment: .leading, spacing: 8) {
                    Text("Monto o beneficio")
                        .font(.headline)
                    Label(LocalizedStringKey(beca.monto), systemImage: "dollarsign.circle")
                        .font(.subheadline)
                        .foregroundStyle(Color.colorverde)
                    if beca.moneda != nil {
                        conversionView
                    }
                    Divider()
                    Text("Documentos solicitados")
                        .font(.headline)
                    ForEach(beca.documentos, id: \.self) { documento in
                        Label(LocalizedStringKey(documento), systemImage: "doc.text")
                            .font(.subheadline)
                    }
                    Divider()
                    Label(LocalizedStringKey(beca.cierre), systemImage: "calendar")
                        .font(.subheadline)
                        .foregroundStyle(beca.diasParaCierre <= 15 ? Color.colorrojo : Color.gray)
                }
                .modifier(TarjetaViewModifier())

                if let url = URL(string: beca.enlace) {
                    Link(destination: url) {
                        Label("Abrir sitio oficial", systemImage: "arrow.up.right.square")
                            .font(.subheadline.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color.colorazulclaro)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }

                Button(action: {
                    estado.postular(beca)
                    mostrarConfirmacion = true
                }) {
                    Label(yaPostulada ? "Ya postulaste" : "Postularme",
                          systemImage: yaPostulada ? "checkmark" : "paperplane")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(yaPostulada ? Color.colorverde : Color.colorazul)
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(yaPostulada)

                if yaPostulada {
                    Button(action: {
                        confirmarCancelacion = true
                    }) {
                        Label("Cancelar postulación", systemImage: "xmark.circle")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.colorrojo)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color.colorrojoclaro)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .padding()
            .anchoMaximo()
        }
        .background(Color.colorfondo)
        .navigationTitle(beca.siglas)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await cargarCambio()
        }
        .alert("¿Cancelar postulación?", isPresented: $confirmarCancelacion) {
            Button("No", role: .cancel) {}
            Button("Sí, cancelar", role: .destructive) {
                estado.cancelarPostulacion(beca)
            }
        } message: {
            Text("La beca seguirá en tus guardadas y podrás postularte de nuevo antes del cierre.")
        }
        .alert("Postulación registrada", isPresented: $mostrarConfirmacion) {
            Button("OK") {}
        } message: {
            Text("Puedes ver su avance en Guardadas › Postuladas.")
        }
    }
}

#Preview {
    NavigationStack {
        BecaDetalleView(beca: BecaViewModel().getBecas()[0])
    }
    .environment(AppEstado())
}
