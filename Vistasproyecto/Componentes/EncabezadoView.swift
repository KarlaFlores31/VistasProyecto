import SwiftUI

struct EncabezadoView: View {
    @Environment(AppEstado.self) var estado
    var alPresionarAjustes: (() -> Void)? = nil

    var body: some View {
        HStack {
            FotoPerfilView(tamano: 32)
            Text("BecaMatch")
                .font(Font.system(size: 20, weight: .bold))
                .foregroundStyle(Color.colorazul)
            Spacer()
            if let accion = alPresionarAjustes {
                Button(action: accion) {
                    Image(systemName: "slider.horizontal.3")
                        .font(.title3)
                        .foregroundStyle(Color.colorazul)
                }
            }
        }
    }
}

#Preview {
    EncabezadoView()
        .padding()
        .environment(AppEstado())
}
