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

       var body: some View {
           VStack {
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
           .padding()
       }
}




#Preview {
    LoginView()
}

