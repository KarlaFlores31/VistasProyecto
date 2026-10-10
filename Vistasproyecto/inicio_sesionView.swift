//
//  inicio_sesionView.swift
//  Vistasproyecto
//
//  Created by Karla Flores on 09/10/26.
//

import SwiftUI

struct inicio_sesionView: View {
    var body: some View {
        VStack{
            HStack(spacing: 100){
                HStack(spacing: 5){
                    Image(systemName: "graduationcap")
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.white)
                        .padding(10)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text("BecaMatch")
                        .foregroundColor(Color.blue)
                        .font(Font.system(size: 20, weight: .bold))
                }
                
                HStack{
                    Circle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10)
                    Text("Ciclo 2026")
                        .font(Font.system(size: 12, weight: .semibold))
                        .foregroundColor(Color.blue)
                }
            }
            
            VStack(alignment: .leading){
                Label("Acceso Oficial a Becas", systemImage: "checkmark.seal")
                    .font(.caption)
                    .padding(3)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .foregroundColor(Color.white)
                
                Text("Bienvenido a BecaMatch")
                    .font(Font.system(size: 30, weight: .bold))
                Text("Conecta con becas nacionales e internacionales según tu perfil académico.")
                    .foregroundColor(Color.black.opacity(0.5))
            }
            
            VStack{
                Button(action:{}){
                    Label("Continuar con correo institucional", systemImage: "building.columns")
                }
                .padding(5)
                .foregroundColor(Color.black)
                
                HStack{
                    Button(action:{}){
                        Label("Apple", systemImage: "applelogo")
                    }
                    .padding(.horizontal,5)
                    .foregroundColor(Color.black)
                    
                    Button(action:{}){
                        Label("Google", systemImage: "applelogo")
                    }
                    .padding(.horizontal,5)
                    .foregroundColor(Color.black)
                }
                
                //colocar o iniciar con tu correo personal
                
                VStack{
                    //textfields
                    
                    Button(action:{}){
                        Text("Iniciar Sesión")
                        Image(systemName: "arrow.right")
                    }
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .font(Font.system(size: 15))
                }
            }
            .frame(width: 325, height: 350)
            .background(Color.gray.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        
    }
}

#Preview{
    inicio_sesionView()
}
