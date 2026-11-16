import SwiftUI

struct RegistroView: View {
    @Environment(AppEstado.self) var estado
    @Environment(\.dismiss) var cerrar
    @State var nombre = ""
    @State var correo = ""
    @State var contra = ""
    @State var confirmar = ""
    @State var mensajeError = ""

    func registrar() {
        if nombre.trimmingCharacters(in: .whitespaces).isEmpty {
            mensajeError = "Escribe tu nombre."
        } else if !AppEstado.correoValido(correo) {
            mensajeError = "Escribe un correo válido."
        } else if Cuentas.existe(correo) {
            mensajeError = "Ya existe una cuenta con ese correo."
        } else if contra.count < 8 {
            mensajeError = "La contraseña debe tener al menos 8 caracteres."
        } else if contra != confirmar {
            mensajeError = "Las contraseñas no coinciden."
        } else {
            Cuentas.registrar(correo: correo, contra: contra)
            estado.iniciarSesion(correo: correo, nombre: nombre.trimmingCharacters(in: .whitespaces))
            cerrar()
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Tus datos") {
                    TextField("Nombre completo", text: $nombre)
                    TextField("Correo electrónico", text: $correo)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                    SecureField("Contraseña (mín. 8 caracteres)", text: $contra)
                    SecureField("Confirmar contraseña", text: $confirmar)
                }
                if mensajeError != "" {
                    Text(LocalizedStringKey(mensajeError))
                        .foregroundStyle(Color.colorrojo)
                }
                Button(action: {
                    registrar()
                }) {
                    Text("Crear cuenta")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Registro")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { cerrar() }
                }
            }
        }
    }
}

#Preview {
    RegistroView()
        .environment(AppEstado())
}
