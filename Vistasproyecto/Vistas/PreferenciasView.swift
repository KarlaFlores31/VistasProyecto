import SwiftUI

struct PreferenciasView: View {
    @Environment(AppEstado.self) var estado
    let becas = BecaViewModel().getBecas()

    func sinRepetir(_ lista: [String]) -> [String] {
        var resultado: [String] = []
        for valor in lista {
            if !resultado.contains(valor) {
                resultado.append(valor)
            }
        }
        return resultado
    }

    var destinos: [String] { sinRepetir(becas.map { $0.pais }) }
    var niveles: [String] { sinRepetir(becas.map { $0.nivel }) }
    var areas: [String] { sinRepetir(becas.map { $0.area }) }
    var coberturas: [String] { sinRepetir(becas.map { $0.coberturaTotal ? "Cobertura total" : "Cobertura parcial" }) }

    func filaOpcion(_ opcion: String) -> some View {
        Button(action: {
            if estado.preferencias.contains(opcion) {
                estado.preferencias.remove(opcion)
            } else {
                estado.preferencias.insert(opcion)
            }
        }) {
            HStack {
                Text(LocalizedStringKey(opcion))
                    .foregroundStyle(Color.primary)
                Spacer()
                if estado.preferencias.contains(opcion) {
                    Image(systemName: "checkmark")
                        .foregroundStyle(Color.colorazul)
                }
            }
        }
    }

    var body: some View {
        Form {
            Section {
                ForEach(destinos, id: \.self) { opcion in
                    filaOpcion(opcion)
                }
            } header: {
                Text("Destinos")
            } footer: {
                Text("Elige todas las opciones que te interesen.")
            }

            Section("Nivel de estudios") {
                ForEach(niveles, id: \.self) { opcion in
                    filaOpcion(opcion)
                }
            }

            Section("Área de conocimiento") {
                ForEach(areas, id: \.self) { opcion in
                    filaOpcion(opcion)
                }
            }

            Section("Tipo de cobertura") {
                ForEach(coberturas, id: \.self) { opcion in
                    filaOpcion(opcion)
                }
            }
        }
        .navigationTitle("Preferencias de beca")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PreferenciasView()
    }
    .environment(AppEstado())
}
