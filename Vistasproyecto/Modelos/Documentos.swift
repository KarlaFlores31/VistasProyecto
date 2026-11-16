import Foundation

struct Documentos {
    static let tamanoMaximo = 2 * 1024 * 1024

    static func guardar(_ url: URL, como tipo: String) -> String? {
        let acceso = url.startAccessingSecurityScopedResource()
        defer {
            if acceso { url.stopAccessingSecurityScopedResource() }
        }

        let tamano = (try? url.resourceValues(forKeys: [.fileSizeKey]).fileSize) ?? 0
        if tamano > tamanoMaximo {
            return String(localized: "El archivo pesa más de 2 MB. Sube un PDF más pequeño.")
        }

        let destino = URL.documentsDirectory.appending(path: "\(tipo).pdf")
        try? FileManager.default.removeItem(at: destino)
        do {
            try FileManager.default.copyItem(at: url, to: destino)
        } catch {
            return String(localized: "No se pudo guardar el archivo. Intenta de nuevo.")
        }
        return nil
    }

    static func borrar(_ tipo: String) {
        try? FileManager.default.removeItem(at: URL.documentsDirectory.appending(path: "\(tipo).pdf"))
    }
}
