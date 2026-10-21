//
//  CheveningTarjetaView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct CheveningTarjetaView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            EncabezadoBecaView(siglas: "CH", institucion: "FOREIGN OFFICE UK", titulo: "Beca Chevening Postgrado Reino Unido")

            HStack {
                EtiquetaView(texto: "94% Compatible", icono: "circle.fill", colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                EtiquetaView(texto: "Cierra en 28 días", icono: "calendar", colorTexto: Color.orange, colorFondo: Color.colorambarclaro)
            }
            EtiquetaView(texto: "Reino Unido")

            HStack {
                Image(systemName: "alarm")
                    .foregroundStyle(Color.colorazul)
                    .frame(width: 32, height: 32)
                    .background(Color.colorazulclaro)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("Alarma programada")
                        .font(.subheadline.weight(.medium))
                    Text("Alertas de seguimiento quincenal")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                }
                Spacer()
                Text("Configurada")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.colorazul)
            }
            .padding(12)
            .background(Color.colorfondo)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 6) {
                Label("Requisitos prioritarios pendientes", systemImage: "exclamationmark.triangle")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.orange)
                Label("Falta carta de recomendación académica firmada", systemImage: "exclamationmark.circle")
                    .foregroundStyle(Color.colorrojo)
                Label("Validación de pasaporte y visa previa completa", systemImage: "checkmark.circle")
                    .foregroundStyle(Color.colorverde)
            }
            .font(.caption)
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.colorambarclaro)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Divider()

            HStack {
                VStack(alignment: .leading) {
                    Text("Cobertura")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                    Text("£30,000 + Vuelos")
                        .font(.title3.weight(.bold))
                        .foregroundStyle(Color.colorverde)
                }
                Spacer()
                Button(action: {}) {
                    Label("Ver detalles y enlaces", systemImage: "arrow.up.right.square")
                        .font(.subheadline.weight(.semibold))
                        .padding(12)
                        .background(Color.colorazulclaro)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .fixedSize()
            }
        }
        .modifier(TarjetaViewModifier())
    }
}

#Preview {
    CheveningTarjetaView()
        .padding()
        .background(Color.colorfondo)
}
