//
//  NotificationManager.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 07/09/24.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager() // Singleton para gerenciar notificações
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Erro ao solicitar permissão: \(error.localizedDescription)")
            } else {
                print("Permissão concedida: \(success)")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Título da Notificação"
        content.subtitle = "Subtítulo da Notificação"
        content.body = "Essa é a mensagem principal da notificação."
        content.sound = .default
        
        // Define o gatilho da notificação (aqui 5 segundos após a execução)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Cria a solicitação de notificação
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // Adiciona a solicitação ao centro de notificações
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erro ao agendar notificação: \(error.localizedDescription)")
            }
        }
    }
}

