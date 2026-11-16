import SwiftUI

struct GuardadasView: View {
    @Environment(AppEstado.self) var estado
    let listaBecas: [BecaModel] = BecaViewModel().getBecas()
    @State var pestaña = 1

    func ordenar(_ becas: [BecaModel]) -> [BecaModel] {
        becas.sorted { $0.diasParaCierre < $1.diasParaCierre }
    }

    var porVencer: [BecaModel] {
        ordenar(listaBecas.filter { estado.guardadas.contains($0.id) && !estado.postuladas.contains($0.id) })
    }

    var postuladas: [BecaModel] {
        ordenar(listaBecas.filter { estado.postuladas.contains($0.id) })
    }

    @ViewBuilder
    func tarjeta(_ beca: BecaModel) -> some View {
        if beca.id == 1 {
            CarolinaTarjetaView()
        } else if beca.id == 2 {
            CheveningTarjetaView()
        } else {
            BecaTarjetaView(beca: beca)
        }
    }

    func avisoCierre(_ beca: BecaModel) -> some View {
        HStack {
            Image(systemName: "hourglass")
            Text("¡Faltan \(beca.diasParaCierre) días para que cierre!")
            Spacer()
        }
        .font(.subheadline.weight(.bold))
        .foregroundStyle(beca.diasParaCierre <= 15 ? Color.colorrojo : Color.colorcafe)
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 26)
        .background(beca.diasParaCierre <= 15 ? Color.colorrojoclaro : Color.colorambarclaro)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    func mensajeVacio(_ texto: LocalizedStringKey) -> some View {
        Text(texto)
            .foregroundStyle(Color.gray)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 40)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    EncabezadoView()

                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Becas Guardadas")
                                .font(Font.system(size: 28, weight: .bold))
                            Text("Gestión de convocatorias y cronograma de postulación")
                                .font(.subheadline)
                                .foregroundStyle(Color.gray)
                        }
                        Spacer()
                        EtiquetaView(texto: "\(estado.guardadas.count) activas", colorTexto: Color.colorazul, colorFondo: Color.colorazulclaro)
                    }

                    HStack(spacing: 0) {
                        BotonPestanaView(texto: "Por vencer (\(porVencer.count))", seleccionado: pestaña == 1) { pestaña = 1 }
                        BotonPestanaView(texto: "Postuladas (\(postuladas.count))", seleccionado: pestaña == 2) { pestaña = 2 }
                    }
                    .padding(4)
                    .background(Color.gray.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    if pestaña == 1 {
                        if porVencer.isEmpty {
                            mensajeVacio("No tienes becas guardadas. Toca el marcador en Explorar para guardar una.")
                        }
                        ForEach(porVencer) { beca in
                            if beca.diasParaCierre <= 60 {
                                VStack(spacing: -16) {
                                    avisoCierre(beca)
                                    tarjeta(beca)
                                }
                            } else {
                                tarjeta(beca)
                            }
                        }
                        BorradorTarjetaView()
                    } else {
                        if postuladas.isEmpty {
                            mensajeVacio("Aún no te has postulado a ninguna beca.")
                        }
                        ForEach(postuladas) { beca in
                            BecaTarjetaView(beca: beca)
                        }
                    }
                }
                .padding()
                .anchoMaximo()
            }
            .background(Color.colorfondo)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    GuardadasView()
        .environment(AppEstado())
}
