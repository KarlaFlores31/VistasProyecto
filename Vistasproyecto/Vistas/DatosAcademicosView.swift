//
//  DatosAcademicosView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct DatosAcademicosView: View {
    @State var nivel = 1
    @State var carrera = "Ingeniería de Software / Computación"
    @State var mostrarAlerta = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "checkmark.seal")
                            .font(.title3)
                            .foregroundStyle(Color.colorazul)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Expediente Verificado")
                                    .font(.headline)
                                Spacer()
                                EtiquetaView(texto: "Oficial", icono: "circle.fill", colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                            }
                            Text("Tus datos se sincronizan con la Dirección General de Administración Escolar para validar la compatibilidad de becas automáticamente.")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    Divider()
                    HStack {
                        Label("Sincronización activa", systemImage: "checkmark.circle")
                            .foregroundStyle(Color.colorverde)
                        Spacer()
                        Text("ID Estudiantil: 22698")
                            .foregroundStyle(Color.gray)
                    }
                    .font(.caption2)
                }
                .modifier(TarjetaViewModifier(colorFondo: Color.colorazulclaro.opacity(0.6)))

                HStack {
                    Text("INFORMACIÓN INSTITUCIONAL")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.gray)
                    Spacer()
                    Label("Datos Certificados", systemImage: "lock")
                        .font(.caption)
                        .foregroundStyle(Color.colorazul)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Universidad / Institución Educativa")
                        .font(.caption.weight(.semibold))
                    HStack {
                        Text("Instituto de Estudios Superiores de Tamaulipas")
                            .lineLimit(1)
                        Spacer()
                        Image(systemName: "lock")
                            .foregroundStyle(Color.gray)
                    }
                    .padding(12)
                    .background(Color.colorfondo)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Label("Cuenta institucional vinculada: estudiante@iest.edu.mx", systemImage: "envelope")
                        .font(.caption2)
                        .foregroundStyle(Color.gray)

                    Text("Nivel Académico")
                        .font(.caption.weight(.semibold))
                    HStack(spacing: 0) {
                        botonNivel(id: 1, texto: "Licenciatura")
                        botonNivel(id: 2, texto: "Maestría")
                        botonNivel(id: 3, texto: "Doctorado")
                    }
                    .padding(4)
                    .background(Color.colorazulclaro)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Text("Carrera o Programa")
                        .font(.caption.weight(.semibold))
                    HStack {
                        TextField("Carrera", text: $carrera)
                        Image(systemName: "graduationcap")
                            .foregroundStyle(Color.gray)
                    }
                    .padding(12)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))

                    Label("Facultad: Facultad de Ingeniería (IEST)", systemImage: "building.2")
                        .font(.caption2)
                        .foregroundStyle(Color.gray)

                    HStack {
                        campoChico(titulo: "Semestre / Avance", valor: "8vo Semestre (85%)", icono: "chevron.up.chevron.down")
                        campoChico(titulo: "Fecha de Egreso", valor: "Diciembre 2026", icono: "calendar")
                    }
                }
                .modifier(TarjetaViewModifier())

                HStack {
                    Text("RENDIMIENTO Y CALIFICACIONES")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.gray)
                    Spacer()
                    EtiquetaView(texto: "Kardex Oficial", colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                }

                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("Promedio General Acumulado")
                                .font(.caption)
                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                Text("9.2")
                                    .font(Font.system(size: 40, weight: .bold))
                                    .foregroundStyle(Color.colorazul)
                                Text("/ 10")
                                    .foregroundStyle(Color.gray)
                            }
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            EtiquetaView(texto: "Excelente", icono: "star.circle", colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                            Text("Top 5% de tu generación")
                                .font(.caption2)
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Label("Simulador de elegibilidad académica", systemImage: "slider.horizontal.3")
                            Spacer()
                            Text("9.2 pts")
                                .foregroundStyle(Color.colorazul)
                        }
                        .font(.caption)
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 6)
                                Circle()
                                    .fill(Color.colorazuloscuro)
                                    .frame(width: 18, height: 18)
                                    .offset(x: geometry.size.width * 0.73 - 9)
                            }
                        }
                        .frame(height: 18)
                        HStack {
                            Text("Mínimo (7.0)")
                            Spacer()
                            Text("8.5 (Corte estándar)")
                            Spacer()
                            Text("Máximo (10.0)")
                        }
                        .font(.caption2)
                        .foregroundStyle(Color.gray)
                    }
                    .padding(12)
                    .background(Color.colorfondo)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    Divider()

                    Label("Última actualización: 15 de Octubre 2026", systemImage: "clock")
                        .font(.caption)

                    Button(action: {}) {
                        Label("Subir nuevo Kardex", systemImage: "doc.badge.arrow.up")
                            .font(.subheadline.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color.colorazulclaro)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .modifier(TarjetaViewModifier())

                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "rosette")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .background(Color.white.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Impacto en Convocatorias")
                                .font(.headline)
                            Spacer()
                            EtiquetaView(texto: "94% Match", colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                        }
                        Text("Con tu promedio actual (**9.2**), desbloqueas el **94% de las convocatorias internacionales** como Fundación Carolina, Santander y Chevening.")
                            .font(.subheadline)
                    }
                }
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.colorazuloscuro)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                Button(action: {
                    mostrarAlerta = true
                }) {
                    Label("Guardar cambios y actualizar compatibilidad", systemImage: "arrow.triangle.2.circlepath")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(Color.colorazul)
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Text("La recalificación de compatibilidad toma menos de 30 segundos.")
                    .font(.caption2)
                    .foregroundStyle(Color.gray)
                    .frame(maxWidth: .infinity)
            }
            .padding()
        }
        .background(Color.colorfondo)
        .navigationTitle("Datos Académicos")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    mostrarAlerta = true
                }) {
                    Text("Guardar")
                        .bold()
                }
            }
        }
        .alert("Cambios guardados", isPresented: $mostrarAlerta) {
            Button("OK") {}
        } message: {
            Text("Tu compatibilidad se actualizó correctamente.")
        }
    }

    func botonNivel(id: Int, texto: String) -> some View {
        Button(action: {
            nivel = id
        }) {
            Text(texto)
                .font(.caption.weight(.semibold))
                .foregroundStyle(nivel == id ? Color.colorazul : Color.black)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(nivel == id ? Color.white : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }

    func campoChico(titulo: String, valor: String, icono: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(titulo)
                .font(.caption.weight(.semibold))
            HStack {
                Text(valor)
                    .font(.subheadline)
                    .lineLimit(1)
                Spacer()
                Image(systemName: icono)
                    .foregroundStyle(Color.gray)
            }
            .padding(12)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
        }
    }
}

#Preview {
    NavigationStack {
        DatosAcademicosView()
    }
}
