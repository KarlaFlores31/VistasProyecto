import SwiftUI

struct ContentView: View {
    @Environment(AppEstado.self) var estado

    var body: some View {
        if estado.sesionIniciada {
            MenuTabView()
        } else {
            InicioSesionView()
        }
    }
}

#Preview {
    ContentView()
        .environment(AppEstado())
}
