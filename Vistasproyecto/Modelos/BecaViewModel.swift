//
//  BecaViewModel.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import Foundation

struct BecaViewModel {
    func getBecas() -> [BecaModel] {
        let becas = [
            BecaModel(id: 1, siglas: "FC",
                      institucion: "Fundación Carolina",
                      subtitulo: "Universidad Politécnica de Madrid",
                      titulo: "Beca Fundación Carolina - Máster en Inteligencia Artificial y Datos",
                      compatibilidad: 98,
                      cierre: "Cierra en 12 días (30 Mayo)",
                      requisitos: ["Promedio > 8.5", "Título Universitario", "Español nativo"],
                      pie: "42 estudiantes IEST aplicaron",
                      iconoPie: "person.3"),
            BecaModel(id: 2, siglas: "CH",
                      institucion: "Gobierno Británico",
                      subtitulo: "Universidades del Reino Unido",
                      titulo: "Beca Chevening - Estudios de Posgrado en Reino Unido",
                      compatibilidad: 94,
                      cierre: "Cierra en 28 días",
                      requisitos: ["2 años exp. laboral / liderazgo", "Nivel Inglés C1", "Retorno al país de origen"],
                      pie: "100% de manutención incluida",
                      iconoPie: "globe.americas"),
            BecaModel(id: 3, siglas: "SAN",
                      institucion: "Banco Santander & Red Universitaria",
                      subtitulo: "Nacional e Internacional",
                      titulo: "Beca de Excelencia Santander - Movilidad Internacional",
                      compatibilidad: 91,
                      cierre: "Abierta hasta Julio",
                      requisitos: ["Promedio mínimo 8.8", "50% de créditos cubiertos", "Carta de aceptación de intercambio"],
                      pie: "Convenio directo con IEST",
                      iconoPie: "building.columns")
        ]
        return becas
    }

    func getMatches() -> [MatchModel] {
        let matches = [
            MatchModel(id: 1, etiqueta: "96% Match", detalle: "Ingeniería de Software", cuando: "Hace 2 horas",
                        titulo: "Beca Google Student Mobility 2025",
                        descripcion: "Nueva convocatoria detectada para Ingeniería de Software. Compatible con tu promedio actual de 9.2 y tus créditos vigentes.",
                        pie: "$12,000 USD + Manutención", accion: "Revisar"),
            MatchModel(id: 2, etiqueta: "Convocatoria abierta", detalle: "100 plazas disponibles", cuando: "Ayer",
                        titulo: "Beca de Excelencia Santander",
                        descripcion: "Se abrieron registros para estancias académicas semestrales en Iberoamérica. Compatible con tu plan de estudios.",
                        pie: "Cierre: 30 de Noviembre", accion: "Ver bases")
        ]
        return matches
    }

    func getOpcionesExpediente() -> [OpcionPerfilModel] {
        let opciones = [
            OpcionPerfilModel(id: 4, icono: "folder", titulo: "Documentos y Kardex Oficial", subtitulo: "Kardex, CV Europass, Cartas"),
            OpcionPerfilModel(id: 5, icono: "globe.europe.africa", titulo: "Preferencias de Beca y Destinos", subtitulo: "Cobertura total · España, UK, Alemania")
        ]
        return opciones
    }

    func getOpcionesCuenta() -> [OpcionPerfilModel] {
        let opciones = [
            OpcionPerfilModel(id: 6, icono: "slider.horizontal.3", titulo: "Ajustes del Algoritmo Match", subtitulo: "Notificaciones y calibración v3.2"),
            OpcionPerfilModel(id: 7, icono: "shield", titulo: "Cuenta Institucional y Seguridad", subtitulo: "estudiante@iest.edu.mx")
        ]
        return opciones
    }
}
