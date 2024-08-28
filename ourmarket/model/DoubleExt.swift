//
//  DoubleExt.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 29/04/24.
//

import Foundation

extension Double {
    func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR") // Define o locale como Brasil para a formatação da moeda brasileira
        
        if let formattedString = formatter.string(from: NSNumber(value: self)) {
            return formattedString
        } else {
            return "R$ \(self)" // Se a formatação falhar, retorna o valor como está
        }
    }
}
