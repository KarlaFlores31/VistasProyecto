import SwiftUI

struct FiltrosView: View {
    @Environment(\.dismiss) var cerrar
    @Binding var pais: Int
    @Binding var nivel: String
    @Binding var area: String
    @Binding var cobertura: Int
    @Binding var ordenarPorCierre: Bool

    var areas: [String] {
        var resultado: [String] = []
        for beca in BecaViewModel().getBecas() {
            if !resultado.contains(beca.area) && beca.area != "Cualquier área" {
                resultado.append(beca.area)
            }
        }
        return resultado.sorted()
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("País") {
                    Picker("País", selection: $pais) {
                        Text("Todos").tag(0)
                        Text("Nacional").tag(1)
                        Text("Extranjero").tag(2)
                    }
                    .pickerStyle(.segmented)
                }

                Section("Nivel de estudios") {
                    Picker("Nivel", selection: $nivel) {
                        Text("Todos").tag("Todos")
                        Text("Bachillerato").tag("Bachillerato")
                        Text("Licenciatura").tag("Licenciatura")
                        Text("Posgrado").tag("Posgrado")
                    }
                }

                Section("Área de conocimiento") {
                    Picker("Área", selection: $area) {
                        Text("Todas").tag("Todas")
                        ForEach(areas, id: \.self) { area in
                            Text(LocalizedStringKey(area)).tag(area)
                        }
                    }
                }

                Section("Tipo de cobertura") {
                    Picker("Cobertura", selection: $cobertura) {
                        Text("Todas").tag(0)
                        Text("Total").tag(1)
                        Text("Parcial").tag(2)
                    }
                    .pickerStyle(.segmented)
                }

                Section("Ordenar") {
                    Picker("Ordenar por", selection: $ordenarPorCierre) {
                        Text("Compatibilidad").tag(false)
                        Text("Fecha de cierre").tag(true)
                    }
                }

                Button("Quitar filtros", role: .destructive) {
                    pais = 0
                    nivel = "Todos"
                    area = "Todas"
                    cobertura = 0
                }
            }
            .navigationTitle("Filtros")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Listo") { cerrar() }
                }
            }
        }
    }
}

#Preview {
    FiltrosView(pais: .constant(0), nivel: .constant("Todos"), area: .constant("Todas"),
                cobertura: .constant(0), ordenarPorCierre: .constant(false))
}
