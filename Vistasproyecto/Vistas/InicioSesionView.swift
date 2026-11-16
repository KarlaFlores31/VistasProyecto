import SwiftUI

struct InicioSesionView: View {
    @Environment(AppEstado.self) var estado
    @State var correo = ""
    @State var contra = ""
    @State var verContra = false
    @State var mensajeError = ""
    @State var mostrarRecuperar = false
    @State var mostrarRegistro = false

    var correoValido: Bool {
        AppEstado.correoValido(correo)
    }

    func iniciarSesion() {
        if !correoValido {
            mensajeError = "Escribe un correo válido."
        } else if !Cuentas.existe(correo) {
            mensajeError = "No hay una cuenta con ese correo. Regístrate primero."
        } else if !Cuentas.contraCorrecta(correo: correo, contra: contra) {
            mensajeError = "La contraseña es incorrecta."
        } else {
            mensajeError = ""
            estado.iniciarSesion(correo: correo)
        }
    }

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
                    Button(action: {
                        estado.iniciarSesion(correo: Cuentas.correoDemo)
                    }) {
                        Label("Continuar con correo institucional", systemImage: "building.columns")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.colorazul)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color.colorazulclaro)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                    }

                    HStack {
                        Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 1)
                        Text("o inicia con tu correo")
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
                            Button(action: {
                                mostrarRecuperar = true
                            }) {
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

                    if mensajeError != "" {
                        Label(LocalizedStringKey(mensajeError), systemImage: "exclamationmark.circle")
                            .font(.caption)
                            .foregroundStyle(Color.colorrojo)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    Button(action: {
                        iniciarSesion()
                    }) {
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
                }
                .modifier(TarjetaViewModifier())

                VStack(spacing: 4) {
                    Text("¿Aún no tienes cuenta?")
                        .foregroundStyle(Color.gray)
                    Button(action: {
                        mostrarRegistro = true
                    }) {
                        Text("Regístrate aquí")
                            .bold()
                    }
                }
                .font(.subheadline)
                .frame(maxWidth: .infinity)

                Text("Al continuar, aceptas nuestros Términos de Servicio y Privacidad Educativa.")
                    .font(.caption2)
                    .foregroundStyle(Color.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .anchoMaximo()
        }
        .background(Color.colorfondo)
        .alert("Recuperar contraseña", isPresented: $mostrarRecuperar) {
            Button("OK") {}
        } message: {
            Text("Tu cuenta se guarda solo en este iPhone. Si ya iniciaste sesión, puedes cambiar tu contraseña en Perfil › Cuenta y seguridad.")
        }
        .sheet(isPresented: $mostrarRegistro) {
            RegistroView()
        }
    }
}

#Preview{
    InicioSesionView()
        .environment(AppEstado())
}
