import SwiftUI

struct CambiarContrasenaView: View {
    @Environment(AppEstado.self) var estado
    @Environment(\.dismiss) var cerrar
    @State var actual = ""
    @State var nueva = ""
    @State var confirmar = ""
    @State var mensajeError = ""
    @State var listo = false

    func cambiar() {
        if !Cuentas.contraCorrecta(correo: estado.correo, contra: actual) {
            mensajeError = "La contraseña actual es incorrecta."
        } else if nueva.count < 8 {
            mensajeError = "La contraseña debe tener al menos 8 caracteres."
        } else if nueva != confirmar {
            mensajeError = "Las contraseñas no coinciden."
        } else if nueva == actual {
            mensajeError = "La nueva contraseña debe ser diferente a la actual."
        } else {
            Cuentas.cambiarContra(correo: estado.correo, nueva: nueva)
            mensajeError = ""
            listo = true
        }
    }

    var body: some View {
        Form {
            Section {
                SecureField("Contraseña actual", text: $actual)
            }
            Section {
                SecureField("Nueva contraseña (mín. 8 caracteres)", text: $nueva)
                SecureField("Confirmar nueva contraseña", text: $confirmar)
            }
            if mensajeError != "" {
                Text(LocalizedStringKey(mensajeError))
                    .foregroundStyle(Color.colorrojo)
            }
            Button(action: {
                cambiar()
            }) {
                Text("Cambiar contraseña")
                    .bold()
                    .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Cambiar contraseña")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Contraseña actualizada", isPresented: $listo) {
            Button("OK") { cerrar() }
        } message: {
            Text("La próxima vez inicia sesión con tu nueva contraseña.")
        }
    }
}

#Preview {
    NavigationStack {
        CambiarContrasenaView()
    }
    .environment(AppEstado())
}
