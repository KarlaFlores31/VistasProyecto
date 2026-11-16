import SwiftUI

struct CuentaView: View {
    @Environment(AppEstado.self) var estado
    @State var confirmarSalida = false

    var body: some View {
        Form {
            Section("Cuenta") {
                LabeledContent("Correo", value: estado.correo)
                LabeledContent("Nombre", value: estado.nombre)
                LabeledContent("Institución", value: estado.institucion == "" ? "—" : estado.institucion)
            }

            Section("Seguridad") {
                NavigationLink("Cambiar contraseña") {
                    CambiarContrasenaView()
                }
                Button("Cerrar sesión", role: .destructive) {
                    confirmarSalida = true
                }
            }
        }
        .navigationTitle("Cuenta y seguridad")
        .navigationBarTitleDisplayMode(.inline)
        .alert("¿Cerrar sesión?", isPresented: $confirmarSalida) {
            Button("Cancelar", role: .cancel) {}
            Button("Cerrar sesión", role: .destructive) {
                estado.cerrarSesion()
            }
        }
    }
}

#Preview {
    NavigationStack {
        CuentaView()
    }
    .environment(AppEstado())
}
