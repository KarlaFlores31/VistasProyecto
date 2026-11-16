import Foundation

struct RespuestaTipoCambio: Codable {
    let amount: Double
    let base: String
    let date: String
    let rates: [String: Double]
}

struct TipoCambioAPI {
    static func convertir(_ cantidad: Double, de moneda: String, a destino: String = "MXN") async throws -> RespuestaTipoCambio {
        let direccion = "https://api.frankfurter.dev/v1/latest?amount=\(cantidad)&from=\(moneda)&to=\(destino)"
        guard let url = URL(string: direccion) else {
            throw URLError(.badURL)
        }

        let (datos, respuesta) = try await URLSession.shared.data(from: url)

        if let http = respuesta as? HTTPURLResponse, http.statusCode != 200 {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(RespuestaTipoCambio.self, from: datos)
    }
}
