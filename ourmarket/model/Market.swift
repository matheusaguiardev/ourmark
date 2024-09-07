//
//  Market.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 29/04/24.
//

import Foundation

struct Market: Identifiable {
    let id: String
    let name: String
    let price: Int
    let itensAmount: Int
    let date: Date
    let productList: [Product]
    let createdBy: String
    
    func sumProductPrice() -> Int {
            let priceSum = productList.reduce(0) { total, product in
                total + product.price
            }
        return priceSum
    }
    
    // Para facilitar a conversão para um dicionário que será salvo no Firebase
     func toDictionary() -> [String: Any] {
         return [
             "id": id,
             "name": name,
             "price": price,
             "itensAmount": itensAmount,
             "date": date.timeIntervalSince1970,
             "products": productList.map { $0.toDictionary() },
             "createdBy": createdBy
         ]
     }
}

let marketStub = Market(
    id: "qwert",
    name: "Mix mateus",
    price: 100,
    itensAmount: 4,
    date: Date(),
    productList: [productStub],
    createdBy: "João"
)
