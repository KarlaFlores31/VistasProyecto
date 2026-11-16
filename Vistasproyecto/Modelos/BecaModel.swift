import Foundation

struct BecaModel: Identifiable, Hashable {
    let id: Int
    let siglas: String
    let institucion: String
    let subtitulo: String
    let titulo: String
    let compatibilidad: Int
    let cierre: String
    let requisitos: [String]
    let pie: String
    let iconoPie: String
    let pais: String
    let internacional: Bool
    let coberturaTotal: Bool
    let diasParaCierre: Int
    let descripcion: String
    let enlace: String
    let nivel: String
    let area: String
    let monto: String
    let documentos: [String]
    var montoValor: Double? = nil
    var moneda: String? = nil
}

struct MatchModel: Identifiable {
    let id: Int
    let etiqueta: String
    let detalle: String
    let cuando: String
    let titulo: String
    let descripcion: String
    let pie: String
    let accion: String
}
