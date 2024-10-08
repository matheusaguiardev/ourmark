//
//  Product.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 29/04/24.
//

import Foundation

class Product : Identifiable {
    init(
        id: String,
        name: String,
        price: Int,
        mark: String,
        details: String,
        quantity: Int,
        unity: Unity,
        substitute: Product?,
        inCart: Bool
    ) {
        self.id = id
        self.name = name
        self.price = price
        self.mark = mark
        self.details = details
        self.quantity = quantity
        self.unity = unity
        self.substitute = substitute
        self.inCart = inCart
    }
    
    let id: String
    let name: String
    let price: Int
    let quantity: Int
    let unity: Unity
    let mark: String
    let substitute: Product?
    let details: String
    var inCart: Bool
    
    func toDictionary() -> [String: Any] {
           var dict: [String: Any] = [
                "id": id,
                "name": name,
                "price": price,
                "quantity": quantity,
                "unity": unity.rawValue,
                "mark": mark,
                "details": details,
                "inCart": inCart
           ]
           
           // Adiciona o substituto ao dicionário, se existir
           if let substitute = substitute {
               dict["substitute"] = [
                   "id": substitute.id,
                   "name": substitute.name,
                   "price": substitute.price,
                   "quantity": substitute.quantity,
                   "unity": substitute.unity.rawValue,
                   "mark": substitute.mark,
                   "details": substitute.details,
                   "inCart": substitute.inCart
               ]
           }
           
           return dict
       }
    
}

let productStub = Product(
    id: "123",
    name: "Pipoca",
    price: 1000,
    mark: "apple",
    details: "comprar sem açucar",
    quantity: 1,
    unity: Unity.Un,
    substitute: nil,
    inCart: false
)
