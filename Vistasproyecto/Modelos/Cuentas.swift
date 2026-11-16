import Foundation
import CryptoKit

struct Cuentas {
    static let correoDemo = "estudiante@iest.edu.mx"
    private static let defaults = UserDefaults.standard

    private static var todas: [String: String] {
        get { defaults.dictionary(forKey: "cuentas") as? [String: String] ?? [:] }
        set { defaults.set(newValue, forKey: "cuentas") }
    }

    private static func cifrar(_ contra: String) -> String {
        let huella = SHA256.hash(data: Data(contra.utf8))
        return huella.map { String(format: "%02x", $0) }.joined()
    }

    static func limpiar(_ correo: String) -> String {
        correo.trimmingCharacters(in: .whitespaces).lowercased()
    }

    static func existe(_ correo: String) -> Bool {
        todas[limpiar(correo)] != nil
    }

    static func registrar(correo: String, contra: String) {
        var cuentas = todas
        cuentas[limpiar(correo)] = cifrar(contra)
        todas = cuentas
    }

    static func contraCorrecta(correo: String, contra: String) -> Bool {
        todas[limpiar(correo)] == cifrar(contra)
    }

    static func cambiarContra(correo: String, nueva: String) {
        registrar(correo: correo, contra: nueva)
    }

    static func crearDemo() {
        if !existe(correoDemo) {
            registrar(correo: correoDemo, contra: "becamatch26")
        }
    }
}
