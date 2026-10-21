//
//  ExplorarView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct ExplorarView: View {
    let listaBecas: [BecaModel] = BecaViewModel().getBecas()
    @State var busqueda = ""
    @State var filtro = 1
    
    func botonFiltro(id: Int, texto: String) -> some View {
        Button(action: {
            filtro = id
        }) {
            Text(texto)
                .font(.caption.weight(.semibold))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(filtro == id ? Color.colorazuloscuro : Color.white)
                .foregroundStyle(filtro == id ? Color.white : Color.black)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.gray.opacity(0.2)))
        }
    }

    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    EncabezadoView()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Hola, Karla")
                                .font(Font.system(size: 28, weight: .bold))
                            Spacer()
                            EtiquetaView(texto: "Perfil 95% completado", icono: "circle.fill",
                                         colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                        }
                        Label("Ingeniería de Software · IEST · Promedio 9.2", systemImage: "graduationcap")
                            .font(.subheadline)
                            .foregroundStyle(Color.gray)
                    }
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.gray)
                        TextField("Buscar becas por universidad, país o carrera", text: $busqueda)
                        
                    }
                    .padding(12)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2)))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            botonFiltro(id: 1, texto: "Alta compatibilidad (+90%)")
                            botonFiltro(id: 2, texto: "Internacional")
                            botonFiltro(id: 3, texto: "Nacional")
                            botonFiltro(id: 4, texto: "Cobertura total")
                        }
                    }
                    
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "sparkles")
                            .font(.title2)
                            .foregroundStyle(Color.white)
                            .frame(width: 44, height: 44)
                            .background(Color.colorazul)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        VStack(alignment: .leading, spacing: 4) {
                            Text("MATCHES PARA TU PERFIL")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(Color.colorazul)
                            Text("3 nuevas convocatorias coinciden con tu perfil en México y Europa")
                                .font(.subheadline.weight(.medium))
                            Text("Calculado con tu GPA 9.2 y línea terminal en Sistemas Inteligentes.")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    .modifier(TarjetaViewModifier(colorFondo: Color.colorazulclaro, colorBorde: Color.colorazul.opacity(0.2)))
                    
                    HStack {
                        Text("Convocatorias sugeridas")
                            .font(.title3.weight(.semibold))
                        Spacer()
                        EtiquetaView(texto: "\(listaBecas.count) activas")
                        Button(action: {}) {
                            Label("Filtros", systemImage: "slider.horizontal.3")
                                .font(.subheadline)
                        }
                    }
                    
                    ForEach(listaBecas, id: \.self.id) { beca in
                        BecaTarjetaView(beca: beca)
                    }
                }
                .padding()
            }
            .background(Color.colorfondo)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ExplorarView()
}
