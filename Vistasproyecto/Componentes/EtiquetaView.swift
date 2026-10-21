//
//  EtiquetaView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct EtiquetaView: View {
    var texto: String
    var icono: String = ""
    var colorTexto: Color = .gray
    var colorFondo: Color = .gray.opacity(0.1)

    var body: some View {
        HStack(spacing: 4) {
            if icono != "" {
                Image(systemName: icono)
            }
            Text(texto)
        }
        .font(.caption)
        .foregroundStyle(colorTexto)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(colorFondo)
        .clipShape(Capsule())
    }
}

#Preview {
    VStack {
        EtiquetaView(texto: "98% Compatible", icono: "circle.fill", colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
    }
}
