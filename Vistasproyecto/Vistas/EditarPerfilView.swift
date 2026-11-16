import SwiftUI
import PhotosUI

struct EditarPerfilView: View {
    @Environment(AppEstado.self) var estado
    @Environment(\.dismiss) var cerrar
    @State var nombre = ""
    @State var pais = ""
    @State var institucion = ""
    @State var nivel = 1
    @State var carrera = ""
    @State var idiomas = ""
    @State var intereses = ""
    @State var fotoElegida: PhotosPickerItem?
    @State var cargado = false

    func guardar() {
        estado.nombre = nombre
        estado.pais = pais
        estado.institucion = institucion
        estado.nivel = nivel
        estado.carrera = carrera
        estado.idiomas = idiomas
        estado.intereses = intereses
        cerrar()
    }

    func campo(_ titulo: LocalizedStringKey, texto: Binding<String>) -> some View {
        HStack {
            Text(titulo)
            TextField(titulo, text: texto)
                .multilineTextAlignment(.trailing)
                .foregroundStyle(Color.gray)
        }
    }

    var body: some View {
        Form {
            Section("Foto de perfil") {
                HStack(spacing: 16) {
                    FotoPerfilView(tamano: 70)
                    VStack(alignment: .leading, spacing: 8) {
                        PhotosPicker("Elegir foto", selection: $fotoElegida, matching: .images)
                            .buttonStyle(.borderless)
                        if estado.foto != nil {
                            Button("Quitar foto", role: .destructive) {
                                estado.foto = nil
                                fotoElegida = nil
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                }
            }

            Section("Datos personales") {
                campo("Nombre", texto: $nombre)
                campo("País de origen", texto: $pais)
            }

            Section("Datos académicos") {
                Picker("Nivel de estudios", selection: $nivel) {
                    Text("Licenciatura").tag(1)
                    Text("Maestría").tag(2)
                    Text("Doctorado").tag(3)
                }
                campo("Carrera", texto: $carrera)
                campo("Institución", texto: $institucion)
            }

            Section("Idiomas e intereses") {
                campo("Idiomas", texto: $idiomas)
                campo("Intereses", texto: $intereses)
            }
        }
        .navigationTitle("Editar perfil")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    guardar()
                }) {
                    Text("Guardar")
                        .bold()
                }
            }
        }
        .onChange(of: fotoElegida) {
            Task {
                if let datos = try? await fotoElegida?.loadTransferable(type: Data.self),
                   let imagen = UIImage(data: datos) {
                    estado.foto = imagen.jpegData(compressionQuality: 0.3)
                }
            }
        }
        .onAppear {
            if !cargado {
                nombre = estado.nombre
                pais = estado.pais
                institucion = estado.institucion
                nivel = estado.nivel
                carrera = estado.carrera
                idiomas = estado.idiomas
                intereses = estado.intereses
                cargado = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditarPerfilView()
    }
    .environment(AppEstado())
}
