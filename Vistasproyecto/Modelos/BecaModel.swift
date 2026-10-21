//
//  BecaModel.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import Foundation

struct BecaModel {
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
}

struct MatchModel {
    let id: Int
    let etiqueta: String
    let detalle: String
    let cuando: String
    let titulo: String
    let descripcion: String
    let pie: String
    let accion: String
}

struct OpcionPerfilModel {
    let id: Int
    let icono: String
    let titulo: String
    let subtitulo: String
}
