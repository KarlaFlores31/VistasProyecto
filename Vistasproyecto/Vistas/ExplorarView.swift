import SwiftUI

struct ExplorarView: View {
    @Environment(AppEstado.self) var estado
    let listaBecas: [BecaModel] = BecaViewModel().getBecas()
    @State var busqueda = ""
    @State var altaCompatibilidad = false
    @State var ordenarPorCierre = false
    @State var mostrarOpciones = false
    @State var filtroPais = 0
    @State var filtroNivel = "Todos"
    @State var filtroArea = "Todas"
    @State var filtroCobertura = 0

    func quitarFiltros() {
        busqueda = ""
        altaCompatibilidad = false
        filtroPais = 0
        filtroNivel = "Todos"
        filtroArea = "Todas"
        filtroCobertura = 0
    }

    var becasFiltradas: [BecaModel] {
        let texto = busqueda.lowercased().trimmingCharacters(in: .whitespaces)
        var resultado = listaBecas.filter { beca in
            if texto.isEmpty { return true }
            return beca.titulo.lowercased().contains(texto)
                || beca.institucion.lowercased().contains(texto)
                || beca.subtitulo.lowercased().contains(texto)
                || beca.pais.lowercased().contains(texto)
                || beca.area.lowercased().contains(texto)
                || beca.nivel.lowercased().contains(texto)
        }
        if altaCompatibilidad { resultado = resultado.filter { $0.compatibilidad >= 90 } }
        if filtroPais == 1 { resultado = resultado.filter { !$0.internacional } }
        if filtroPais == 2 { resultado = resultado.filter { $0.internacional } }
        if filtroNivel != "Todos" { resultado = resultado.filter { $0.nivel == filtroNivel } }
        if filtroArea != "Todas" { resultado = resultado.filter { $0.area == filtroArea || $0.area == "Cualquier área" } }
        if filtroCobertura == 1 { resultado = resultado.filter { $0.coberturaTotal } }
        if filtroCobertura == 2 { resultado = resultado.filter { !$0.coberturaTotal } }
        if ordenarPorCierre {
            return resultado.sorted { $0.diasParaCierre < $1.diasParaCierre }
        }
        return resultado.sorted { $0.compatibilidad > $1.compatibilidad }
    }

    func botonFiltro(_ texto: LocalizedStringKey, activo: Bool, accion: @escaping () -> Void) -> some View {
        Button(action: accion) {
            Text(texto)
                .font(.caption.weight(.semibold))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(activo ? Color.colorazuloscuro : Color.colortarjeta)
                .foregroundStyle(activo ? Color.white : Color.primary)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.gray.opacity(0.2)))
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    EncabezadoView(alPresionarAjustes: { mostrarOpciones = true })

                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Hola, \(estado.primerNombre)")
                                .font(Font.system(size: 28, weight: .bold))
                            Spacer()
                            EtiquetaView(texto: "Perfil \(estado.porcentajePerfil)% completado", icono: "circle.fill",
                                         colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                        }
                        Group {
                            if estado.carrera == "" || estado.promedio == 0 {
                                Label("Completa tu perfil para ver becas para ti", systemImage: "graduationcap")
                            } else {
                                Label("\(estado.carrera) · Promedio \(String(format: "%.1f", estado.promedio))", systemImage: "graduationcap")
                            }
                        }
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                    }

                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.gray)
                        TextField("Buscar becas por universidad, país o carrera", text: $busqueda)
                        if busqueda != "" {
                            Button(action: {
                                busqueda = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(Color.gray)
                            }
                        }
                    }
                    .padding(12)
                    .background(Color.colortarjeta)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2)))

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            botonFiltro("Alta compatibilidad (+90%)", activo: altaCompatibilidad) { altaCompatibilidad.toggle() }
                            botonFiltro("Internacional", activo: filtroPais == 2) { filtroPais = filtroPais == 2 ? 0 : 2 }
                            botonFiltro("Nacional", activo: filtroPais == 1) { filtroPais = filtroPais == 1 ? 0 : 1 }
                            botonFiltro("Cobertura total", activo: filtroCobertura == 1) { filtroCobertura = filtroCobertura == 1 ? 0 : 1 }
                        }
                    }

                    HStack {
                        Text("Convocatorias sugeridas")
                            .font(.title3.weight(.semibold))
                        Spacer()
                        EtiquetaView(texto: "\(becasFiltradas.count) activas")
                        Button(action: {
                            mostrarOpciones = true
                        }) {
                            Label("Filtros", systemImage: "slider.horizontal.3")
                                .font(.subheadline)
                        }
                    }

                    ForEach(becasFiltradas) { beca in
                        BecaTarjetaView(beca: beca)
                    }

                    if becasFiltradas.isEmpty {
                        VStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                                .font(.title)
                            Text("No hay becas que coincidan con tu búsqueda.")
                            Button("Quitar filtros") {
                                quitarFiltros()
                            }
                        }
                        .foregroundStyle(Color.gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 30)
                    }
                }
                .padding()
                .anchoMaximo()
            }
            .background(Color.colorfondo)
            .navigationBarHidden(true)
            .sheet(isPresented: $mostrarOpciones) {
                FiltrosView(pais: $filtroPais, nivel: $filtroNivel, area: $filtroArea,
                            cobertura: $filtroCobertura, ordenarPorCierre: $ordenarPorCierre)
            }
        }
    }
}

#Preview {
    ExplorarView()
        .environment(AppEstado())
}
