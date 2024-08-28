//
//  Product.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 29/04/24.
//

import Foundation

class Product {
    init(
        name: String,
        price: Double,
        mark: String,
        details: String,
        quantity: Int,
        unity: Unity,
        substitute: Product?
    ) {
        self.name = name
        self.price = price
        self.mark = mark
        self.details = details
        self.quantity = quantity
        self.unity = unity
        self.substitute = substitute
    }
    
    let name: String
    let price: Double
    let quantity: Int
    let unity: Unity
    let mark: String
    let substitute: Product?
    let details: String
    
}

let productStub = Product(
    name: "Pipoca",
    price: 100.0,
    mark: "apple",
    details: "comprar sem açucar",
    quantity: 1,
    unity: Unity.Un,
    substitute: nil
)

extension Product {
    
}
