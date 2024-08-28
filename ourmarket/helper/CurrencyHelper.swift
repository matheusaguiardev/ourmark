//
//  CurrencyHelper.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 30/04/24.
//

import Foundation

func formatCoin(_ texto: String) -> String {
    let valor = (texto as NSString).doubleValue
    
    // Se o valor for zero ou negativo, retorna uma string vazia
    guard valor > 0 else {
        return ""
    }
    
    // Formata o valor como moeda
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "pt_BR") // Define o locale como Brasil para a formatação da moeda brasileira
    
    if let formattedString = formatter.string(from: NSNumber(value: valor)) {
        return formattedString
    } else {
        return "R$ \(valor)" // Se a formatação falhar, retorna o valor como está
    }
}
