import SwiftUI

struct AlertasView: View {
    @Environment(AppEstado.self) var estado
    @State var pestana = 1
    @State var becaAbierta: BecaModel?
    @State var abrirExpediente = false
    @State var avisoPrueba = false

    var expedienteCompleto: Bool {
        estado.kardexNombre != "" && estado.cvNombre != "" && estado.cartasNombre != ""
    }

    func matchDe(_ beca: BecaModel) -> MatchModel {
        MatchModel(id: beca.id, etiqueta: "\(beca.compatibilidad)% Match", detalle: beca.pais, cuando: beca.cierre,
                   titulo: beca.titulo, descripcion: beca.descripcion, pie: beca.monto, accion: "Revisar")
    }

    func tarjetaVencimiento(_ beca: BecaModel) -> some View {
        let id = AppEstado.idVencimiento(beca)
        return VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label(expedienteCompleto ? "Recordatorio" : "Acción Requerida",
                      systemImage: estado.alertasLeidas.contains(id) ? "circle" : "circle.fill")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.colorrojo)
                Spacer()
                Label(LocalizedStringKey(beca.cierre), systemImage: "calendar")
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            Text(LocalizedStringKey(beca.titulo))
                .font(.headline)
            if !expedienteCompleto {
                Label("Te faltan documentos en tu expediente", systemImage: "exclamationmark.triangle")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .background(Color.colorrojoclaro.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            Button(action: {
                estado.marcarLeida(id)
                if expedienteCompleto {
                    becaAbierta = beca
                } else {
                    abrirExpediente = true
                }
            }) {
                Label(expedienteCompleto ? "Ver beca" : "Completar expediente", systemImage: "doc")
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .background(Color.colorazul)
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .modifier(TarjetaViewModifier())
    }

    func tituloSeccion(icono: String, texto: LocalizedStringKey, color: Color) -> some View {
        HStack {
            Image(systemName: icono)
                .foregroundStyle(color)
            Text(texto)
                .font(.title3.weight(.semibold))
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Alertas")
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.colorazul)
                        if estado.alertasNuevas > 0 {
                            EtiquetaView(texto: "\(estado.alertasNuevas) nuevas", colorTexto: Color.colorrojo, colorFondo: Color.colorrojoclaro)
                        } else {
                            EtiquetaView(texto: "Al día", colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                        }
                        Spacer()
                        Button(action: {
                            estado.marcarTodasLeidas()
                        }) {
                            Label("Marcar leídas", systemImage: "checkmark")
                                .font(.caption.weight(.semibold))
                        }
                    }

                    HStack(spacing: 0) {
                        BotonPestanaView(texto: "Todas", seleccionado: pestana == 1) { pestana = 1 }
                        BotonPestanaView(texto: "Convocatorias", seleccionado: pestana == 2) { pestana = 2 }
                        BotonPestanaView(texto: "Vencimientos", seleccionado: pestana == 3) { pestana = 3 }
                        BotonPestanaView(texto: "Matches", seleccionado: pestana == 4) { pestana = 4 }
                    }
                    .padding(4)
                    .background(Color.colorazulclaro)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    HStack(spacing: 12) {
                        Image(systemName: "bell.badge")
                            .foregroundStyle(Color.colorazul)
                            .frame(width: 36, height: 36)
                            .background(Color.colorazulclaro)
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Recordatorios activados")
                                .font(.subheadline.weight(.semibold))
                            Text("Te avisamos 3 días antes del cierre de tus becas guardadas.")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                        }
                        Spacer()
                        Button("Probar") {
                            Notificaciones.shared.probarNotificacion()
                            avisoPrueba = true
                        }
                        .font(.caption.weight(.semibold))
                    }
                    .modifier(TarjetaViewModifier())

                    if estado.idsAlertas.isEmpty {
                        VStack(spacing: 10) {
                            Image(systemName: "bell.slash")
                                .font(.largeTitle)
                                .foregroundStyle(Color.gray)
                            Text("No tienes alertas todavía")
                                .font(.headline)
                            Text("Elige tus preferencias en Perfil y guarda becas para recibir matches y avisos de cierre.")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 30)
                        .modifier(TarjetaViewModifier())
                    }

                    if (pestana == 1 || pestana == 3) && !estado.becasPorVencer.isEmpty {
                    tituloSeccion(icono: "timer", texto: "Urgente / Próximas a cerrar", color: Color.colorrojo)

                    ForEach(estado.becasPorVencer) { beca in
                        tarjetaVencimiento(beca)
                    }
                    }

                    if (pestana == 1 || pestana == 2 || pestana == 4) && !estado.becasMatch.isEmpty {
                    tituloSeccion(icono: "scope", texto: pestana == 2 ? "Convocatorias abiertas" : "Nuevos Matches con tu perfil", color: Color.colorverde)

                    ForEach(estado.becasMatch) { beca in
                        MatchTarjetaView(match: matchDe(beca), leida: estado.alertasLeidas.contains(beca.id), alAccion: {
                            estado.marcarLeida(beca.id)
                            becaAbierta = beca
                        }, destacada: true)
                    }
                    }
                }
                .padding()
                .anchoMaximo()
            }
            .background(Color.colorfondo)
            .navigationBarHidden(true)
            .navigationDestination(item: $becaAbierta) { beca in
                BecaDetalleView(beca: beca)
            }
            .navigationDestination(isPresented: $abrirExpediente) {
                DatosAcademicosView()
            }
            .alert("Notificación programada", isPresented: $avisoPrueba) {
                Button("OK") {}
            } message: {
                Text("Llegará en 5 segundos.")
            }
        }
    }
}

#Preview {
    AlertasView()
        .environment(AppEstado())
}
