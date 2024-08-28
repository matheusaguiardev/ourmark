//
//  Market.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 29/04/24.
//

import Foundation

struct Market {
    let name: String
    let price: Double
    let itensAmount: Int
    let date: Date
    let productList: [Product]
    let createdBy: String
}

let marketStub = Market(
    name: "Mix mateus",
    price: 100,
    itensAmount: 4,
    date: Date(),
    productList: [productStub],
    createdBy: "João"
)
