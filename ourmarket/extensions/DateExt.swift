//
//  DateExt.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 29/04/24.
//

import Foundation

extension Date {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR") // Define o locale como Brasil para o formato da data
        let anoAtual = Calendar.current.component(.year, from: Date())
        let anoData = Calendar.current.component(.year, from: self)
        
        if anoData == anoAtual {
            formatter.dateFormat = "dd/MMM"
        } else {
            formatter.dateFormat = "dd/MMM/yyyy"
        }
        
        return formatter.string(from: self)
    }
}
