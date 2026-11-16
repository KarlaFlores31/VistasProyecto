import SwiftUI

struct FotoPerfilView: View {
    @Environment(AppEstado.self) var estado
    var tamano: CGFloat = 32

    var body: some View {
        if let datos = estado.foto, let imagen = UIImage(data: datos) {
            Image(uiImage: imagen)
                .resizable()
                .scaledToFill()
                .frame(width: tamano, height: tamano)
                .clipShape(Circle())
        } else {
            Text(estado.iniciales)
                .font(Font.system(size: tamano * 0.38, weight: .bold))
                .foregroundStyle(Color.white)
                .frame(width: tamano, height: tamano)
                .background(Color.colorazul)
                .clipShape(Circle())
        }
    }
}

#Preview {
    FotoPerfilView(tamano: 70)
        .environment(AppEstado())
}
