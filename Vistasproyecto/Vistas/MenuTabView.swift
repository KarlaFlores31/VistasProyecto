import SwiftUI

struct MenuTabView: View {
    @Environment(AppEstado.self) var estado

    var body: some View {
        TabView {
            Tab("Explorar", systemImage: "safari") {
                ExplorarView()
            }
            Tab("Guardadas", systemImage: "bookmark") {
                GuardadasView()
            }
            .badge(estado.guardadas.count)
            Tab("Alertas", systemImage: "bell") {
                AlertasView()
            }
            .badge(estado.alertasNuevas)
            Tab("Perfil", systemImage: "graduationcap") {
                PerfilView()
            }
        }
        .tint(Color.colorazul)
        .onAppear {
            Notificaciones.shared.pedirPermiso()
            for beca in BecaViewModel().getBecas() {
                if estado.guardadas.contains(beca.id) && Notificaciones.shared.estaActivo(beca) {
                    Notificaciones.shared.programarRecordatorio(beca)
                }
            }
        }
    }
}

#Preview {
    MenuTabView()
        .environment(AppEstado())
}
