//
//  inicio_sesionView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 09/10/26.
//

import SwiftUI

struct inicio_sesionView: View {
    @State var correo = ""
    @State var contra = ""
    @State var verContra = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    HStack(spacing: 5) {
                        Image(systemName: "graduationcap")
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.white)
                            .padding(6)
                            .background(Color.colorazul)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        Text("BecaMatch")
                            .foregroundStyle(Color.colorazul)
                            .font(Font.system(size: 20, weight: .bold))
                    }
                    Spacer()
                    HStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 8, height: 8)
                        Text("Ciclo 2026")
                            .font(Font.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color.colorazul)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    EtiquetaView(texto: "Acceso Oficial a Becas", icono: "checkmark.seal",
                                 colorTexto: Color.colorazul, colorFondo: Color.colorazulclaro)
                    Text("Bienvenido a BecaMatch")
                        .font(Font.system(size: 28, weight: .bold))
                    Text("Conecta con becas nacionales e internacionales según tu perfil académico.")
                        .foregroundStyle(Color.gray)
                }

                VStack(spacing: 14) {
                    Button(action: {}) {
                        Label("Continuar con correo institucional", systemImage: "building.columns")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.colorazul)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color.colorazulclaro)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    HStack {
                        Button(action: {}) {
                            Label("Apple", systemImage: "applelogo")
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .background(Color.black)
                                .foregroundStyle(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Button(action: {}) {
                            HStack {
                                Text("G")
                                    .bold()
                                    .foregroundStyle(Color.colorazul)
                                Text("Google")
                                    .foregroundStyle(Color.black)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                        }
                    }
                    .font(.subheadline.weight(.semibold))

                    HStack {
                        Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 1)
                        Text("o inicia con tu correo personal")
                            .font(.caption2)
                            .foregroundStyle(Color.gray)
                            .fixedSize()
                        Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 1)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Correo electrónico")
                            .font(.caption.weight(.semibold))
                        HStack {
                            TextField("estudiante@iest.edu.mx", text: $correo)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled(true)
                                .keyboardType(.emailAddress)
                            Image(systemName: "envelope")
                                .foregroundStyle(Color.gray)
                        }
                        .padding(12)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Contraseña")
                                .font(.caption.weight(.semibold))
                            Spacer()
                            Button(action: {}) {
                                Text("¿Olvidaste tu contraseña?")
                                    .font(.caption)
                            }
                        }
                        HStack {
                            if verContra {
                                TextField("Ingresa al menos 8 caracteres", text: $contra)
                            } else {
                                SecureField("Ingresa al menos 8 caracteres", text: $contra)
                            }
                            Button(action: {
                                verContra.toggle()
                            }) {
                                Image(systemName: verContra ? "eye.slash" : "eye")
                                    .foregroundStyle(Color.gray)
                            }
                        }
                        .padding(12)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                    }

                    Button(action: {}) {
                        HStack {
                            Text("Iniciar Sesión")
                            Image(systemName: "arrow.right")
                        }
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(Color.colorazul)
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    HStack {
                        Image(systemName: "bolt.fill")
                            .foregroundStyle(Color.colorverde)
                        Text("Algoritmo de Compatibilidad")
                            .font(.caption2)
                            .foregroundStyle(Color.gray)
                        Spacer()
                        EtiquetaView(texto: "v3.2 Activo", colorTexto: Color.colorverde, colorFondo: Color.colorverdeclaro)
                    }
                }
                .modifier(TarjetaViewModifier())

                VStack(spacing: 4) {
                    Text("¿Aún no tienes cuenta?")
                        .foregroundStyle(Color.gray)
                    Button(action: {}) {
                        Text("Regístrate aquí y calcula tu compatibilidad")
                            .bold()
                    }
                }
                .font(.subheadline)
                .frame(maxWidth: .infinity)

                HStack {
                    Image(systemName: "checkmark.shield")
                        .foregroundStyle(Color.colorverde)
                    Text("Respaldado por más de 50 universidades e instituciones aliadas")
                        .font(.caption2)
                        .foregroundStyle(Color.gray)
                }
                .modifier(TarjetaViewModifier(colorFondo: Color.colorazulclaro.opacity(0.5)))

                Text("Al continuar, aceptas nuestros Términos de Servicio y Privacidad Educativa.")
                    .font(.caption2)
                    .foregroundStyle(Color.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .padding()
        }
        .background(Color.colorfondo)
    }
}

#Preview{
    inicio_sesionView()
}
