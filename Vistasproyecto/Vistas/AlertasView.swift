//
//  AlertasView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct AlertasView: View {
    let listaMatches: [MatchModel] = BecaViewModel().getMatches()
    @State var nuevas = 3
    @State var pestana = 1
    
    func botonPestaña(id: Int, texto: String) -> some View {
        Button(action: {
            pestana = id
        }) {
            Text(texto)
                .font(.caption.weight(.semibold))
                .foregroundStyle(pestana == id ? Color.colorazul : Color.black)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(pestana == id ? Color.white : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }

    func tituloSeccion(icono: String, texto: String, color: Color) -> some View {
        HStack {
            Image(systemName: icono)
                .foregroundStyle(color)
            Text(texto)
                .font(.title3.weight(.semibold))
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    HStack {
                        Text("Alertas")
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.colorazul)
                        EtiquetaView(texto: "\(nuevas) nuevas", colorTexto: Color.colorrojo, colorFondo: Color.colorrojoclaro)
                        Spacer()
                        Button(action: {

                        }) {
                            Label("Marcar leídas", systemImage: "checkmark")
                                .font(.caption.weight(.semibold))
                        }
                        Image(systemName: "slider.horizontal.3")
                            .foregroundStyle(Color.colorazul)
                    }


                    HStack(spacing: 0) {
                        botonPestaña(id: 1, texto: "Todas")
                        botonPestaña(id: 2, texto: "Convocatorias")
                        botonPestaña(id: 3, texto: "Vencimientos")
                        botonPestaña(id: 4, texto: "Matches")
                    }
                    .padding(4)
                    .background(Color.colorazulclaro)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    tituloSeccion(icono: "timer", texto: "Urgente / Próximas a cerrar", color: Color.colorrojo)

                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Label("Acción Requerida", systemImage: "circle.fill")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(Color.colorrojo)
                            Spacer()
                            Label("Cierra en 12 días", systemImage: "calendar")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                        }
                        Text("Beca Fundación Carolina 2025")
                            .font(.headline)
                        Text("¡Atención! La Beca Fundación Carolina cierra en 12 días. Te falta subir 1 documento para completar tu expediente y no perder tu candidatura.")
                            .font(.subheadline)
                            .foregroundStyle(Color.gray)
                        HStack {
                            Label("Falta: Constancia de idioma B2", systemImage: "exclamationmark.triangle")
                            Spacer()
                            Text("85% listo")
                                .foregroundStyle(Color.colorrojo)
                        }
                        .font(.caption)
                        .padding(10)
                        .background(Color.colorrojoclaro.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                        Button(action: {}) {
                            Label("Completar expediente", systemImage: "doc")
                                .font(.subheadline.weight(.semibold))
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .background(Color.colorazul)
                                .foregroundStyle(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .modifier(TarjetaViewModifier())

                    tituloSeccion(icono: "scope", texto: "Nuevos Matches con tu perfil", color: Color.colorverde)

                    ForEach(listaMatches, id: \.self.id) { match in
                        MatchTarjetaView(match: match)
                    }

                    tituloSeccion(icono: "gearshape.2", texto: "Actualizaciones del sistema", color: Color.gray)

                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "checkmark.circle")
                            .font(.title3)
                            .foregroundStyle(Color.colorverde)
                            .frame(width: 40, height: 40)
                            .background(Color.colorverdeclaro)
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(alignment: .top) {
                                Text("Perfil validado exitosamente")
                                    .font(.headline)
                                Spacer()
                                Text("Hace 3 días")
                                    .font(.caption2)
                                    .foregroundStyle(Color.gray)
                            }
                            Text("Tu perfil fue actualizado exitosamente: Validación de promedio IEST al 100% procesada por el departamento de becas.")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    .modifier(TarjetaViewModifier())
                }
                .padding()
            }
            .background(Color.colorfondo)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    AlertasView()
}
