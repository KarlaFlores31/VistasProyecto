//
//  EncabezadoBecaView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct EncabezadoBecaView: View {
    var siglas: String
    var institucion: String
    var titulo: String

    var body: some View {
        HStack(alignment: .top) {
            SiglasView(siglas: siglas)
            VStack(alignment: .leading, spacing: 2) {
                Text(institucion)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                Text(titulo)
                    .font(.headline)
            }
            Spacer()
            Image(systemName: "bookmark.fill")
                .foregroundStyle(Color.colorazul)
        }
    }
}

#Preview {
    EncabezadoBecaView(siglas: "FC", institucion: "FUNDACIÓN CAROLINA", titulo: "Máster en Inteligencia Artificial Aplicada")
        .padding()
}
