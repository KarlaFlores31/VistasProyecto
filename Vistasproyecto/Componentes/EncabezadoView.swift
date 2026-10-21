//
//  EncabezadoView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct EncabezadoView: View {
    var body: some View {
        HStack {
            Text("KF")
                .font(Font.system(size: 13, weight: .bold))
                .foregroundStyle(Color.white)
                .frame(width: 32, height: 32)
                .background(Color.colorazul)
                .clipShape(Circle())
            Text("BecaMatch")
                .font(Font.system(size: 20, weight: .bold))
                .foregroundStyle(Color.colorazul)
            Spacer()
            Button(action: {}) {
                Image(systemName: "slider.horizontal.3")
                    .font(.title3)
                    .foregroundStyle(Color.colorazul)
            }
        }
    }
}

#Preview {
    EncabezadoView()
        .padding()
}
