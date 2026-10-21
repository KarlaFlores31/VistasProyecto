//
//  FilaOpcionView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct FilaOpcionView: View {
    var icono: String
    var titulo: String
    var subtitulo: String
    var etiqueta: String = ""

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icono)
                .foregroundStyle(Color.colorazul)
                .frame(width: 32, height: 32)
                .background(Color.colorazulclaro)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(titulo)
                        .font(.subheadline.weight(.semibold))
                    if etiqueta != "" {
                        EtiquetaView(texto: etiqueta, colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                    }
                }
                Text(subtitulo)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.gray)
        }
        .padding(12)
    }
}

#Preview {
    VStack(spacing: 0) {
        FilaOpcionView(icono: "graduationcap", titulo: "Datos Universitarios y Promedio", subtitulo: "IEST · Licenciatura · 9.2 GPA")
        FilaOpcionView(icono: "folder", titulo: "Documentos y Kardex Oficial", subtitulo: "Kardex, CV Europass, Cartas", etiqueta: "3 listos")
    }
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .padding()
    .background(Color.colorfondo)
}
