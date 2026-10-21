//
//  PerfilView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct PerfilView: View {
    let opcionesExpediente: [OpcionPerfilModel] = BecaViewModel().getOpcionesExpediente()
    let opcionesCuenta: [OpcionPerfilModel] = BecaViewModel().getOpcionesCuenta()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Mi Perfil Académico")
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.colorazul)
                        Spacer()
                        Image(systemName: "slider.horizontal.3")
                            .foregroundStyle(Color.colorazul)
                    }

                    
                    HStack(spacing: 14) {
                        Text("KF")
                            .font(Font.system(size: 24, weight: .bold))
                            .foregroundStyle(Color.white)
                            .frame(width: 70, height: 70)
                            .background(Color.colorazul)
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Karla Flores")
                                .font(.title3.weight(.bold))
                            EtiquetaView(texto: "Verificado", colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                            Text("Ingeniería de Software · IEST")
                                .font(.subheadline)
                                .foregroundStyle(Color.colorazul)
                            Label("Perfil 95% completado para becas", systemImage: "checkmark.circle.fill")
                                .font(.caption2)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    .modifier(TarjetaViewModifier())

                    
                    Text("INFORMACIÓN ACADÉMICA")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.gray)
                    VStack(spacing: 0) {
                        NavigationLink(destination: DatosAcademicosView()) {
                            FilaOpcionView(icono: "graduationcap", titulo: "Datos Universitarios y Promedio", subtitulo: "IEST · Licenciatura · 9.2 GPA")
                        }
                        .buttonStyle(.plain)
                        NavigationLink(destination: DatosAcademicosView()) {
                            FilaOpcionView(icono: "character.bubble", titulo: "Idiomas y Certificaciones", subtitulo: "Español, Inglés (B2), Francés (A1)")
                        }
                        .buttonStyle(.plain)
                        NavigationLink(destination: DatosAcademicosView()) {
                            FilaOpcionView(icono: "brain", titulo: "Áreas de Interés y Especialidad", subtitulo: "IA, Datos, Sistemas Distribuidos")
                        }
                        .buttonStyle(.plain)
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Text("EXPEDIENTE Y POSTULACIONES")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.gray)
                    VStack(spacing: 0) {
                        ForEach(opcionesExpediente, id: \.self.id) { opcion in
                            FilaOpcionView(icono: opcion.icono, titulo: opcion.titulo, subtitulo: opcion.subtitulo, etiqueta: opcion.id == 4 ? "3 listos" : "")
                        }
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Text("CUENTA Y COMPATIBILIDAD")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.gray)
                    VStack(spacing: 0) {
                        ForEach(opcionesCuenta, id: \.self.id) { opcion in
                            FilaOpcionView(icono: opcion.icono, titulo: opcion.titulo, subtitulo: opcion.subtitulo, etiqueta: opcion.id == 4 ? "3 listos" : "")
                        }
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    
                    Button(action: {}) {
                        Label("Cerrar sesión", systemImage: "rectangle.portrait.and.arrow.right")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.colorrojo)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .padding(.top, 8)
                }
                .padding()
            }
            .background(Color.colorfondo)
            .navigationTitle("Perfil")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    PerfilView()
}
