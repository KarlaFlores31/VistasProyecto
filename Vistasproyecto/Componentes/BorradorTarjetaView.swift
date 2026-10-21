//
//  BorradorTarjetaView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI


struct BorradorTarjetaView: View {
    func filaDocumento(titulo: String, detalle: String, listo: Bool) -> some View {
        HStack {
            Image(systemName: listo ? "checkmark.seal" : "pencil.and.list.clipboard")
                .foregroundStyle(listo ? Color.colorverde : Color.orange)
            VStack(alignment: .leading) {
                Text(titulo)
                    .font(.caption.weight(.semibold))
                Text(detalle)
                    .font(.caption2)
                    .foregroundStyle(listo ? Color.gray : Color.orange)
            }
            Spacer()
            Image(systemName: listo ? "eye" : "pencil")
                .foregroundStyle(Color.gray)
        }
        .padding(12)
        .background(listo ? Color.colorfondo : Color.colorambarclaro)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Image(systemName: "folder")
                    .foregroundStyle(Color.colorazul)
                    .frame(width: 32, height: 32)
                    .background(Color.colorazulclaro)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                VStack(alignment: .leading) {
                    Text("Borrador rápido de postulación")
                        .font(.headline)
                    Text("Expediente centralizado para postulaciones")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                }
                Spacer()
                Button(action: {}) {
                    Text("Editar")
                        .font(.caption.weight(.semibold))
                }
            }

            filaDocumento(titulo: "Kardex Oficial", detalle: "Actualizado (PDF)", listo: true)
            filaDocumento(titulo: "CV Académico", detalle: "Europass v3.2", listo: true)
            filaDocumento(titulo: "Carta de motivos", detalle: "En revisión (85%)", listo: false)
        }
        .modifier(TarjetaViewModifier())
    }
}

#Preview {
    BorradorTarjetaView()
        .padding()
        .background(Color.colorfondo)
}
