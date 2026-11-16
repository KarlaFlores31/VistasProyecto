import UserNotifications

class Notificaciones: NSObject, UNUserNotificationCenterDelegate {
    static let shared = Notificaciones()
    let centro = UNUserNotificationCenter.current()

    func pedirPermiso() {
        centro.delegate = self
        centro.requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    func estaActivo(_ beca: BecaModel) -> Bool {
        UserDefaults.standard.object(forKey: "recordatorio-\(beca.id)") as? Bool ?? true
    }

    func programarRecordatorio(_ beca: BecaModel) {
        let dias = beca.diasParaCierre - 3
        if dias <= 0 { return }

        let contenido = UNMutableNotificationContent()
        contenido.title = String(localized: "Recordatorio de beca")
        contenido.body = String(localized: "La convocatoria \(beca.titulo) cierra en 3 días. ¡No olvides postularte!")
        contenido.sound = .default

        let segundos = Double(dias * 24 * 60 * 60)
        let disparador = UNTimeIntervalNotificationTrigger(timeInterval: segundos, repeats: false)
        let solicitud = UNNotificationRequest(identifier: "beca-\(beca.id)", content: contenido, trigger: disparador)
        centro.add(solicitud)
    }

    func cancelarRecordatorio(_ beca: BecaModel) {
        centro.removePendingNotificationRequests(withIdentifiers: ["beca-\(beca.id)"])
    }

    func probarNotificacion() {
        let contenido = UNMutableNotificationContent()
        contenido.title = String(localized: "Nueva convocatoria compatible")
        contenido.body = String(localized: "Beca Google Student Mobility 2025 coincide con tu perfil (96% Match).")
        contenido.sound = .default

        let disparador = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let solicitud = UNNotificationRequest(identifier: "prueba", content: contenido, trigger: disparador)
        centro.add(solicitud)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.banner, .sound]
    }
}
