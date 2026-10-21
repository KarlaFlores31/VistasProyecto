//
//  MatchTarjetaView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct MatchTarjetaView: View {
    var match: MatchModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                EtiquetaView(texto: match.etiqueta,
                             colorTexto: match.id == 1 ? Color.colorverde : Color.colorazul,
                             colorFondo: match.id == 1 ? Color.colorverdeclaro : Color.colorazulclaro)
                Text(match.detalle)
                    .font(.caption2)
                    .foregroundStyle(Color.gray)
                Spacer()
                Text(match.cuando)
                    .font(.caption2)
                    .foregroundStyle(Color.gray)
            }
            Text(match.titulo)
                .font(.headline)
            Text(match.descripcion)
                .font(.caption)
                .foregroundStyle(Color.gray)
            HStack {
                Text(match.pie)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(match.id == 1 ? Color.colorverde : Color.gray)
                Spacer()
                Button(action: {}) {
                    Label(match.accion, systemImage: "arrow.right")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.colorazulclaro)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .modifier(TarjetaViewModifier())
    }
}

#Preview {
    MatchTarjetaView(match: BecaViewModel().getMatches()[0])
        .padding()
        .background(Color.colorfondo)
}
