import SwiftUI
import UniformTypeIdentifiers

struct PerfilView: View {
    @Environment(AppEstado.self) var estado
    @State var confirmarSalida = false
    let niveles = [String(localized: "Licenciatura"), String(localized: "Maestría"), String(localized: "Doctorado")]

    @State var documentoElegido = ""
    @State var mostrarImportador = false
    @State var mensajeError = ""
    @State var mostrarError = false
    @State var mostrarOpcionesDocumento = false

    func filaDocumento(tipo: String, icono: String, titulo: LocalizedStringKey, archivo: String, obligatorio: Bool) -> some View {
        Button(action: {
            documentoElegido = tipo
            if archivo == "" {
                mostrarImportador = true
            } else {
                mostrarOpcionesDocumento = true
            }
        }) {
            FilaOpcionView(icono: icono, titulo: titulo,
                           subtitulo: archivo == "" ? "Sube un PDF (máx. 2 MB)" : "\(archivo)",
                           etiqueta: archivo != "" ? "Subido" : (obligatorio ? "Obligatorio" : "Opcional"),
                           colorEtiqueta: archivo != "" ? Color.colorverde : (obligatorio ? Color.colorcafe : Color.gray),
                           fondoEtiqueta: archivo != "" ? Color.colorverdeclaro : (obligatorio ? Color.colorambarclaro : Color.gray.opacity(0.1)))
        }
        .buttonStyle(.plain)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Mi Perfil Académico")
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.colorazul)
                        Spacer()
                        NavigationLink(destination: EditarPerfilView()) {
                            Image(systemName: "square.and.pencil")
                                .foregroundStyle(Color.colorazul)
                        }
                    }

                    HStack(spacing: 14) {
                        FotoPerfilView(tamano: 70)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(estado.nombre)
                                .font(.title3.weight(.bold))
                            if estado.carrera != "" || estado.institucion != "" {
                                Text([estado.carrera, estado.institucion].filter { $0 != "" }.joined(separator: " · "))
                                    .font(.subheadline)
                                    .foregroundStyle(Color.colorazul)
                            }
                            if estado.pais != "" {
                                Label(estado.pais, systemImage: "mappin.and.ellipse")
                                    .font(.caption)
                                    .foregroundStyle(Color.gray)
                            }
                            Label("Perfil \(estado.porcentajePerfil)% completado para becas", systemImage: "checkmark.circle.fill")
                                .font(.caption2)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    .modifier(TarjetaViewModifier())

                    NavigationLink(destination: EditarPerfilView()) {
                        Label("Editar perfil", systemImage: "square.and.pencil")
                            .font(.subheadline.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color.colorazulclaro)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    Text("INFORMACIÓN ACADÉMICA")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.gray)
                    VStack(spacing: 0) {
                        NavigationLink(destination: DatosAcademicosView()) {
                            FilaOpcionView(icono: "graduationcap", titulo: "Datos Universitarios y Promedio", subtitulo: estado.promedio == 0 ? "Toca para capturar tu promedio" : "\(niveles[estado.nivel - 1]) · \(String(format: "%.1f", estado.promedio)) GPA")
                        }
                        .buttonStyle(.plain)
                        NavigationLink(destination: EditarPerfilView()) {
                            FilaOpcionView(icono: "character.bubble", titulo: "Idiomas y Certificaciones", subtitulo: estado.idiomas == "" ? "Toca para agregar tus idiomas" : LocalizedStringKey(estado.idiomas))
                        }
                        .buttonStyle(.plain)
                        NavigationLink(destination: EditarPerfilView()) {
                            FilaOpcionView(icono: "brain", titulo: "Áreas de Interés y Especialidad", subtitulo: estado.intereses == "" ? "Toca para agregar tus intereses" : LocalizedStringKey(estado.intereses))
                        }
                        .buttonStyle(.plain)
                    }
                    .background(Color.colortarjeta)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Text("EXPEDIENTE Y POSTULACIONES")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.gray)
                    VStack(spacing: 0) {
                        filaDocumento(tipo: "kardex", icono: "doc.text", titulo: "Kardex", archivo: estado.kardexNombre, obligatorio: true)
                        filaDocumento(tipo: "cv", icono: "person.text.rectangle", titulo: "CV", archivo: estado.cvNombre, obligatorio: true)
                        filaDocumento(tipo: "cartas", icono: "envelope.open", titulo: "Cartas de recomendación", archivo: estado.cartasNombre, obligatorio: false)
                        NavigationLink(destination: PreferenciasView()) {
                            FilaOpcionView(icono: "globe.europe.africa", titulo: "Preferencias de Beca y Destinos",
                                           subtitulo: estado.preferencias.isEmpty ? "Toca para elegir tus preferencias" : "\(estado.preferencias.count) preferencias elegidas")
                        }
                        .buttonStyle(.plain)
                    }
                    .background(Color.colortarjeta)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Text("CUENTA")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.gray)
                    VStack(spacing: 0) {
                        NavigationLink(destination: CuentaView()) {
                            FilaOpcionView(icono: "shield", titulo: "Cuenta Institucional y Seguridad",
                                           subtitulo: "\(estado.correo)")
                        }
                        .buttonStyle(.plain)
                    }
                    .background(Color.colortarjeta)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Button(action: {
                        confirmarSalida = true
                    }) {
                        Label("Cerrar sesión", systemImage: "rectangle.portrait.and.arrow.right")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.colorrojo)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.colortarjeta)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .padding(.top, 8)
                }
                .padding()
                .anchoMaximo()
            }
            .background(Color.colorfondo)
            .navigationTitle("Perfil")
            .navigationBarHidden(true)
            .fileImporter(isPresented: $mostrarImportador, allowedContentTypes: [.pdf]) { resultado in
                if case .success(let url) = resultado {
                    if let error = estado.subirDocumento(url, tipo: documentoElegido) {
                        mensajeError = error
                        mostrarError = true
                    }
                }
            }
            .confirmationDialog("¿Qué quieres hacer con este archivo?", isPresented: $mostrarOpcionesDocumento, titleVisibility: .visible) {
                Button("Reemplazar archivo") {
                    mostrarImportador = true
                }
                Button("Quitar archivo", role: .destructive) {
                    estado.quitarDocumento(documentoElegido)
                }
                Button("Cancelar", role: .cancel) {}
            }
            .alert("No se pudo subir el archivo", isPresented: $mostrarError) {
                Button("OK") {}
            } message: {
                Text(mensajeError)
            }
            .alert("¿Cerrar sesión?", isPresented: $confirmarSalida) {
                Button("Cancelar", role: .cancel) {}
                Button("Cerrar sesión", role: .destructive) {
                    estado.cerrarSesion()
                }
            }
        }
    }
}

#Preview {
    PerfilView()
        .environment(AppEstado())
}
