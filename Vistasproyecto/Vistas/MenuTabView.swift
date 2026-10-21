//
//  MenuTabView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 18/10/26.
//

import SwiftUI

struct MenuTabView: View {

    var body: some View {
        TabView {
            Tab("Explorar", systemImage: "safari") {
                ExplorarView()
            }
            Tab("Guardadas", systemImage: "bookmark") {
                GuardadasView()
            }
            .badge(2)
            Tab("Alertas", systemImage: "bell") {
                AlertasView()
            }
            .badge(3)
            Tab("Perfil", systemImage: "graduationcap") {
                PerfilView()
            }
        }
        .tint(Color.colorazul)
    }
}

#Preview {
    MenuTabView()
}
