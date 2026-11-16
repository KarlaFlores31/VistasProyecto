import SwiftUI
import UniformTypeIdentifiers

struct DatosAcademicosView: View {
    @Environment(AppEstado.self) var estado
    @State var nivel = 1
    @State var carrera = ""
    @State var promedio = 9.2
    @State var mostrarAlerta = false
    @State var cargado = false
    @State var elegirKardex = false
    @State var errorKardex = ""
    @State var mostrarErrorKardex = false

    func guardarCambios() {
        estado.nivel = nivel
        estado.carrera = carrera
        estado.promedio = promedio
        mostrarAlerta = true
    }

    var porcentajeMatch: Int {
        Int(min(100, max(0, (promedio - 6.0) / 3.4 * 100)))
    }

    var textoNivelPromedio: LocalizedStringKey {
        if promedio >= 9.0 { return "Excelente" }
        if promedio >= 8.5 { return "Muy bueno" }
        if promedio >= 8.0 { return "Bueno" }
        return "Por mejorar"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("INFORMACIÓN INSTITUCIONAL")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.gray)
                    Spacer()
                    Label("Datos Certificados", systemImage: "lock")
                        .font(.caption)
                        .foregroundStyle(Color.colorazul)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Universidad / Institución Educativa")
                        .font(.caption.weight(.semibold))
                    HStack {
                        Text(estado.institucion == "" ? "Agrégala en Editar perfil" : "\(estado.institucion)")
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding(12)
                    .background(Color.colorfondo)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Label("Cuenta vinculada: \(estado.correo)", systemImage: "envelope")
                        .font(.caption2)
                        .foregroundStyle(Color.gray)

                    Text("Nivel Académico")
                        .font(.caption.weight(.semibold))
                    HStack(spacing: 0) {
                        BotonPestanaView(texto: "Licenciatura", seleccionado: nivel == 1) { nivel = 1 }
                        BotonPestanaView(texto: "Maestría", seleccionado: nivel == 2) { nivel = 2 }
                        BotonPestanaView(texto: "Doctorado", seleccionado: nivel == 3) { nivel = 3 }
                    }
                    .padding(4)
                    .background(Color.colorazulclaro)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Text("Carrera o Programa")
                        .font(.caption.weight(.semibold))
                    HStack {
                        TextField("Carrera", text: $carrera)
                        Image(systemName: "graduationcap")
                            .foregroundStyle(Color.gray)
                    }
                    .padding(12)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))

                }
                .modifier(TarjetaViewModifier())

                HStack {
                    Text("RENDIMIENTO Y CALIFICACIONES")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.gray)
                    Spacer()
                    EtiquetaView(texto: "Kardex Oficial", colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                }

                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("Promedio General Acumulado")
                                .font(.caption)
                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                Text(String(format: "%.1f", promedio))
                                    .font(Font.system(size: 40, weight: .bold))
                                    .foregroundStyle(Color.colorazul)
                                Text("/ 10")
                                    .foregroundStyle(Color.gray)
                            }
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            EtiquetaView(texto: textoNivelPromedio, icono: "star.circle",
                                         colorTexto: promedio >= 8.5 ? Color.colorverde : Color.orange,
                                         colorFondo: promedio >= 8.5 ? Color.colorverdeclaro : Color.colorambarclaro)
                            Text(promedio >= 8.5 ? "Arriba del corte estándar" : "Debajo del corte estándar (8.5)")
                                .font(.caption2)
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Label("Simulador de elegibilidad académica", systemImage: "slider.horizontal.3")
                            Spacer()
                            Text(String(format: "%.1f pts", promedio))
                                .foregroundStyle(Color.colorazul)
                        }
                        .font(.caption)
                        Slider(value: $promedio, in: 7.0...10.0, step: 0.1)
                            .tint(Color.colorazuloscuro)
                        HStack {
                            Text("Mínimo (7.0)")
                            Spacer()
                            Text("8.5 (Corte estándar)")
                            Spacer()
                            Text("Máximo (10.0)")
                        }
                        .font(.caption2)
                        .foregroundStyle(Color.gray)
                    }
                    .padding(12)
                    .background(Color.colorfondo)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    Divider()

                    if estado.kardexNombre == "" {
                        Label("Aún no subes tu Kardex", systemImage: "clock")
                            .font(.caption)
                    } else {
                        Label("Última actualización: \(estado.kardexFecha)", systemImage: "clock")
                            .font(.caption)
                        Label(estado.kardexNombre, systemImage: "doc.fill")
                            .font(.caption)
                            .foregroundStyle(Color.colorverde)
                    }

                    Button(action: {
                        elegirKardex = true
                    }) {
                        Label("Subir nuevo Kardex", systemImage: "doc.badge.arrow.up")
                            .font(.subheadline.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color.colorazulclaro)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .modifier(TarjetaViewModifier())

                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "rosette")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .background(Color.white.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Impacto en Convocatorias")
                                .font(.headline)
                            Spacer()
                            EtiquetaView(texto: "\(porcentajeMatch)% Match", colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                        }
                        Text("Con tu promedio actual (**\(String(format: "%.1f", promedio))**), desbloqueas el **\(porcentajeMatch)% de las convocatorias internacionales** como Fundación Carolina, Santander y Chevening.")
                            .font(.subheadline)
                    }
                }
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.colorazuloscuro)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                Button(action: {
                    guardarCambios()
                }) {
                    Label("Guardar cambios y actualizar compatibilidad", systemImage: "arrow.triangle.2.circlepath")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(Color.colorazul)
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Text("La recalificación de compatibilidad toma menos de 30 segundos.")
                    .font(.caption2)
                    .foregroundStyle(Color.gray)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .anchoMaximo()
        }
        .background(Color.colorfondo)
        .navigationTitle("Datos Académicos")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    guardarCambios()
                }) {
                    Text("Guardar")
                        .bold()
                }
            }
        }
        .fileImporter(isPresented: $elegirKardex, allowedContentTypes: [.pdf]) { resultado in
            if case .success(let url) = resultado {
                if let error = estado.subirDocumento(url, tipo: "kardex") {
                    errorKardex = error
                    mostrarErrorKardex = true
                }
            }
        }
        .onAppear {
            if !cargado {
                nivel = estado.nivel
                carrera = estado.carrera
                promedio = estado.promedio == 0 ? 8.0 : estado.promedio
                cargado = true
            }
        }
        .alert("No se pudo subir el archivo", isPresented: $mostrarErrorKardex) {
            Button("OK") {}
        } message: {
            Text(errorKardex)
        }
        .alert("Cambios guardados", isPresented: $mostrarAlerta) {
            Button("OK") {}
        } message: {
            Text("Tu compatibilidad se actualizó correctamente.")
        }
    }
}

#Preview {
    NavigationStack {
        DatosAcademicosView()
    }
    .environment(AppEstado())
}
