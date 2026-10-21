//
//  BecaTarjetaView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct BecaTarjetaView: View {
    var beca: BecaModel
    @State var guardada: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                SiglasView(siglas: beca.siglas)
                VStack(alignment: .leading) {
                    Text(beca.institucion)
                    Text(beca.subtitulo)
                }
                .font(.caption)
                Spacer()
                Button(action: {
                    guardada.toggle()
                }) {
                    Image(systemName: guardada ? "bookmark.fill" : "bookmark")
                        .font(.title3)
                        .foregroundStyle(Color.colorazul)
                }
            }

            HStack {
                EtiquetaView(texto: "\(beca.compatibilidad)% Compatible", icono: "circle.fill",
                             colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                .fixedSize()
                EtiquetaView(texto: beca.cierre, icono: "clock")
                    .fixedSize()
            }

            Text(beca.titulo)
                .font(Font.system(size: 20, weight: .medium))

            Text("Requisitos clave destacados:")
                .font(.caption)
                .foregroundStyle(Color.gray)
            VStack(alignment: .leading, spacing: 6) {
                ForEach(beca.requisitos, id: \.self) { requisito in
                    EtiquetaView(texto: requisito, icono: "checkmark.circle")
                }
            }

            Divider()

            HStack {
                Image(systemName: beca.iconoPie)
                    .foregroundStyle(Color.colorazul)
                Text(beca.pie)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                Spacer()
                Button(action: {}) {
                    HStack {
                        Text("Ver convocatoria")
                            .fixedSize()
                        Image(systemName: "arrow.right")
                    }
                    .font(.subheadline.weight(.semibold))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Color.colorazul)
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .modifier(TarjetaViewModifier())
    }
}

#Preview {
    BecaTarjetaView(beca: BecaViewModel().getBecas()[0])
        .padding()
        .background(Color.colorfondo)
}
