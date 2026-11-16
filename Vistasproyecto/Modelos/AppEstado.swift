import SwiftUI
import Observation
import UserNotifications

@Observable
class AppEstado {
    private let defaults = UserDefaults.standard
    private var cargando = false

    var sesionIniciada: Bool { didSet { guardar() } }
    var correo: String { didSet { guardar() } }

    var nombre = "" { didSet { guardar() } }
    var guardadas: Set<Int> = [] { didSet { guardar() } }
    var postuladas: Set<Int> = [] { didSet { guardar() } }
    var alertasLeidas: Set<Int> = [] { didSet { guardar() } }
    var carrera = "" { didSet { guardar() } }
    var nivel = 1 { didSet { guardar() } }
    var promedio = 0.0 { didSet { guardar() } }
    var institucion = "" { didSet { guardar() } }
    var pais = "" { didSet { guardar() } }
    var idiomas = "" { didSet { guardar() } }
    var intereses = "" { didSet { guardar() } }
    var foto: Data? { didSet { guardar() } }
    var preferencias: Set<String> = [] { didSet { guardar() } }

    var kardexNombre = "" { didSet { guardar() } }
    var kardexFecha = "" { didSet { guardar() } }
    var cvNombre = "" { didSet { guardar() } }
    var cartasNombre = "" { didSet { guardar() } }

    private let todasLasBecas = BecaViewModel().getBecas()

    // Becas guardadas (sin postular) ordenadas por fecha de cierre
    var becasPorVencer: [BecaModel] {
        todasLasBecas
            .filter { guardadas.contains($0.id) && !postuladas.contains($0.id) }
            .sorted { $0.diasParaCierre < $1.diasParaCierre }
    }

    // Becas que coinciden con al menos una preferencia del usuario
    var becasMatch: [BecaModel] {
        if preferencias.isEmpty { return [] }
        return todasLasBecas
            .filter { beca in
                let cobertura = beca.coberturaTotal ? "Cobertura total" : "Cobertura parcial"
                return preferencias.contains(beca.pais) || preferencias.contains(beca.nivel)
                    || preferencias.contains(beca.area) || preferencias.contains(cobertura)
            }
            .sorted { $0.compatibilidad > $1.compatibilidad }
    }

    static func idVencimiento(_ beca: BecaModel) -> Int { 1000 + beca.id }

    var idsAlertas: [Int] {
        becasPorVencer.map { AppEstado.idVencimiento($0) } + becasMatch.map { $0.id }
    }

    init() {
        Cuentas.crearDemo()
        sesionIniciada = defaults.bool(forKey: "sesionIniciada")
        correo = defaults.string(forKey: "correo") ?? ""
        if correo != "" {
            cargarDatos()
        }
    }

    private func clave(_ dato: String) -> String {
        "\(correo)|\(dato)"
    }

    var esDemo: Bool {
        correo == Cuentas.correoDemo
    }

    private func leer<T>(_ dato: String, vacio: T, demo: T) -> T {
        if let valor = defaults.object(forKey: clave(dato)) as? T {
            return valor
        }
        if esDemo {
            return defaults.object(forKey: dato) as? T ?? demo
        }
        return vacio
    }

    private func cargarDatos() {
        cargando = true
        nombre = leer("nombre", vacio: "", demo: "Karla Flores")
        guardadas = Set(leer("guardadas", vacio: [Int](), demo: [1, 2]))
        postuladas = Set(leer("postuladas", vacio: [Int](), demo: []))
        alertasLeidas = Set(leer("alertasLeidas", vacio: [Int](), demo: []))
        carrera = leer("carrera", vacio: "", demo: "Ingeniería de Software / Computación")
        nivel = leer("nivel", vacio: 1, demo: 1)
        promedio = leer("promedio", vacio: 0.0, demo: 9.2)
        institucion = leer("institucion", vacio: "", demo: "IEST")
        pais = leer("pais", vacio: "", demo: "México")
        idiomas = leer("idiomas", vacio: "", demo: "Español, Inglés (B2), Francés (A1)")
        intereses = leer("intereses", vacio: "", demo: "IA, Datos, Sistemas Distribuidos")
        foto = defaults.data(forKey: clave("foto")) ?? (esDemo ? defaults.data(forKey: "foto") : nil)
        preferencias = Set(leer("preferencias", vacio: [String](), demo: ["Cobertura total", "Madrid, España", "Reino Unido", "Alemania"]))
        kardexNombre = leer("kardexNombre", vacio: "", demo: "")
        kardexFecha = leer("kardexFecha", vacio: "", demo: "")
        cvNombre = leer("cvNombre", vacio: "", demo: "")
        cartasNombre = leer("cartasNombre", vacio: "", demo: "")
        cargando = false
    }

    private func guardar() {
        if cargando { return }
        defaults.set(sesionIniciada, forKey: "sesionIniciada")
        defaults.set(correo, forKey: "correo")
        if correo == "" { return }
        defaults.set(nombre, forKey: clave("nombre"))
        defaults.set(Array(guardadas), forKey: clave("guardadas"))
        defaults.set(Array(postuladas), forKey: clave("postuladas"))
        defaults.set(Array(alertasLeidas), forKey: clave("alertasLeidas"))
        defaults.set(carrera, forKey: clave("carrera"))
        defaults.set(nivel, forKey: clave("nivel"))
        defaults.set(promedio, forKey: clave("promedio"))
        defaults.set(institucion, forKey: clave("institucion"))
        defaults.set(pais, forKey: clave("pais"))
        defaults.set(idiomas, forKey: clave("idiomas"))
        defaults.set(intereses, forKey: clave("intereses"))
        defaults.set(foto, forKey: clave("foto"))
        defaults.set(Array(preferencias), forKey: clave("preferencias"))
        defaults.set(kardexNombre, forKey: clave("kardexNombre"))
        defaults.set(kardexFecha, forKey: clave("kardexFecha"))
        defaults.set(cvNombre, forKey: clave("cvNombre"))
        defaults.set(cartasNombre, forKey: clave("cartasNombre"))
    }

    var porcentajePerfil: Int {
        let campos = [nombre != "", carrera != "", institucion != "", pais != "", idiomas != "",
                      intereses != "", promedio > 0, kardexNombre != "", cvNombre != "", foto != nil]
        let llenos = campos.filter { $0 }.count
        return llenos * 100 / campos.count
    }

    var iniciales: String {
        let partes = nombre.split(separator: " ").prefix(2)
        let letras = partes.compactMap { $0.first }.map { String($0) }.joined()
        return letras.isEmpty ? "?" : letras.uppercased()
    }

    var primerNombre: String {
        String(nombre.split(separator: " ").first ?? "")
    }

    var alertasNuevas: Int {
        idsAlertas.filter { !alertasLeidas.contains($0) }.count
    }

    static func correoValido(_ correo: String) -> Bool {
        let partes = correo.split(separator: "@")
        return partes.count == 2 && partes[1].contains(".")
    }

    func subirDocumento(_ url: URL, tipo: String) -> String? {
        if let error = Documentos.guardar(url, como: "\(correo)-\(tipo)") {
            return error
        }
        let nombre = url.lastPathComponent
        if tipo == "kardex" {
            kardexNombre = nombre
            kardexFecha = Date().formatted(date: .long, time: .omitted)
        }
        if tipo == "cv" { cvNombre = nombre }
        if tipo == "cartas" { cartasNombre = nombre }
        return nil
    }

    func quitarDocumento(_ tipo: String) {
        Documentos.borrar("\(correo)-\(tipo)")
        if tipo == "kardex" { kardexNombre = "" }
        if tipo == "cv" { cvNombre = "" }
        if tipo == "cartas" { cartasNombre = "" }
    }

    func iniciarSesion(correo: String, nombre: String? = nil) {
        cargando = true
        self.correo = Cuentas.limpiar(correo)
        cargando = false
        cargarDatos()
        if let nombre = nombre {
            self.nombre = nombre
        }
        sesionIniciada = true
    }

    func cerrarSesion() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        sesionIniciada = false
    }

    func estaGuardada(_ beca: BecaModel) -> Bool {
        guardadas.contains(beca.id)
    }

    func alternarGuardada(_ beca: BecaModel) {
        if guardadas.contains(beca.id) {
            guardadas.remove(beca.id)
            Notificaciones.shared.cancelarRecordatorio(beca)
        } else {
            guardadas.insert(beca.id)
            if Notificaciones.shared.estaActivo(beca) {
                Notificaciones.shared.programarRecordatorio(beca)
            }
        }
    }

    func postular(_ beca: BecaModel) {
        postuladas.insert(beca.id)
        guardadas.insert(beca.id)
    }

    func cancelarPostulacion(_ beca: BecaModel) {
        postuladas.remove(beca.id)
        guardadas.insert(beca.id)
    }

    func marcarLeida(_ id: Int) {
        alertasLeidas.insert(id)
    }

    func marcarTodasLeidas() {
        alertasLeidas.formUnion(idsAlertas)
    }
}
