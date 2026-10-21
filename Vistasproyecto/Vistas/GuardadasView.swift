//
//  GuardadasView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct GuardadasView: View {
    @State var orden = 1
    @State var pestaña = 1
    
    func botonOrden(id: Int, texto: String) -> some View {
        Button(action: {
            orden = id
        }) {
            Text(texto)
                .font(.caption.weight(.semibold))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(orden == id ? Color.colorazuloscuro : Color.white)
                .foregroundStyle(orden == id ? Color.white : Color.black)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.gray.opacity(0.2)))
        }
    }

    func botonPestañas(id: Int, texto: String) -> some View {
        Button(action: {
            pestaña = id
        }) {
            Text(texto)
                .font(.caption.weight(.semibold))
                .foregroundStyle(pestaña == id ? Color.colorazul : Color.black)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(pestaña == id ? Color.white : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    EncabezadoView()

                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Becas Guardadas")
                                .font(Font.system(size: 28, weight: .bold))
                            Text("Gestión de convocatorias y cronograma de postulación")
                                .font(.subheadline)
                                .foregroundStyle(Color.gray)
                        }
                        Spacer()
                        EtiquetaView(texto: "2 activas", colorTexto: Color.colorazul, colorFondo: Color.colorazulclaro)
                    }

                    
                    HStack {
                        Label("Ordenar:", systemImage: "arrow.up.arrow.down")
                            .font(.caption)
                            .foregroundStyle(Color.gray)
                        botonOrden(id: 1, texto: "Por fecha de cierre")
                        botonOrden(id: 2, texto: "Por compatibilidad")
                    }

                    
                    HStack(spacing: 12) {
                        Image(systemName: "alarm")
                            .font(.title2)
                            .foregroundStyle(Color.white)
                            .frame(width: 48, height: 48)
                            .background(Color.colorazuloscuro)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        VStack(alignment: .leading, spacing: 2) {
                            Text("2 convocatorias por vencer")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(Color.colorazul)
                            Text("Próximo cierre en **12 días**. Recordatorios activados.")
                                .font(.subheadline)
                                .foregroundStyle(Color.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.colorazul)
                    }
                    .modifier(TarjetaViewModifier(colorFondo: Color.colorazulclaro, colorBorde: Color.colorazul.opacity(0.3)))

                    
                    HStack(spacing: 0) {
                        botonPestañas(id: 1, texto: "Por vencer (2)")
                        botonPestañas(id: 2, texto: "Postuladas (1)")
                        botonPestañas(id: 3, texto: "Historial")
                    }
                    .padding(4)
                    .background(Color.gray.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    if pestaña == 1 {
                        CarolinaTarjetaView()
                        CheveningTarjetaView()
                        BorradorTarjetaView()
                    } else {
                        Text("Aquí aparecerán tus becas de esta sección.")
                            .foregroundStyle(Color.gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
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
    GuardadasView()
}
