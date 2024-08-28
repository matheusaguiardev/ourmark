//
//  AuthViewModel.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 27/08/24.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: User?

    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Configuração do Google Sign-In
        let config = GIDConfiguration(clientID: clientID)

        // Pegue o view controller atual
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("Não há um view controller principal!")
            return
        }

        // Realize o Sign-In com Google
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                print("Erro durante o Google Sign-In: \(error.localizedDescription)")
                return
            }

            // Obtenha o GIDGoogleUser
            guard let user = result?.user else {
                print("Erro ao obter o usuário do Google Sign-In.")
                return
            }

            let accessToken = user.accessToken.tokenString
            
            // Obtenha o ID Token e o Access Token
            guard let idToken = user.idToken?.tokenString else {
                print("Erro ao obter o token do usuário.")
                return
            }

            // Crie as credenciais para o Firebase
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

            // Autenticar com Firebase usando AuthCredential
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Erro durante a autenticação Firebase: \(error.localizedDescription)")
                    return
                }

                // Autenticação bem-sucedida
                self.user = authResult?.user
            }
        }
    }
}
