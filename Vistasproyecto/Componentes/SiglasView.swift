//
//  SiglasView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct SiglasView: View {
    var siglas: String

    var body: some View {
        Text(siglas)
            .font(Font.system(size: 16, weight: .bold))
            .foregroundStyle(Color.colorazul)
            .frame(width: 44, height: 44)
            .background(Color.colorazulclaro)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    HStack {
        SiglasView(siglas: "FC")
        SiglasView(siglas: "SAN")
    }
}
