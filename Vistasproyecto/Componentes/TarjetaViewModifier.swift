//
//  TarjetaViewModifier.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct TarjetaViewModifier: ViewModifier {
    var colorFondo: Color = .white
    var colorBorde: Color = .gray.opacity(0.2)

    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(colorFondo)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(colorBorde))
    }
}
