import SwiftUI

@main
struct VistasproyectoApp: App {
    @State var estado = AppEstado()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(estado)
        }
    }
}
