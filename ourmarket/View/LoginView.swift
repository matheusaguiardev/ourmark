//
//  LoginView.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 14/07/24.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var isLoggedIn = false
    
       var body: some View {
               VStack {
                   if isLoggedIn {
                       NavigationLink(destination: HomeView(owner: viewModel.user?.displayName ?? "Anonimo"), isActive: $isLoggedIn) {
                           EmptyView() // Link invisível para navegação automática
                       }
                  }
                   
                   if let user = viewModel.user {
                       Text("Bem-vindo, \(user.displayName ?? "Usuário")!")
                   } else {
                       Button(action: {
                           viewModel.signInWithGoogle()
                       }) {
                           Text("Login com Google")
                               .font(.title)
                               .padding()
                               .background(Color.blue)
                               .foregroundColor(.white)
                               .cornerRadius(8)
                       }
                   }
               }
               .navigationTitle("Login")
               .onAppear {
                           // Verifica se o usuário está logado quando a view aparece
                   isLoggedIn = viewModel.user != nil
               }
               .onChange(of: viewModel.user) { oldUser, newUser in
                   isLoggedIn = newUser != oldUser && newUser != nil
               }
               .padding()
       }
}

#Preview {
    LoginView()
}
