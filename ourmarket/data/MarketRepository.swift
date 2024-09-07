//
//  MarketRepository.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 03/09/24.
//

import FirebaseDatabase

class MarketRepository {
    func addMarket(market: Market) {
        let ref = Database.database().reference().child("markets").child(market.id)
        ref.setValue(market.toDictionary())
    }

    func updateMarket(market: Market) {
        let ref = Database.database().reference().child("markets").child(market.id)
        ref.updateChildValues(market.toDictionary())
    }
    
    func updateProducts(market: Market, newProduct: Product) {
        let ref = Database.database().reference().child("markets").child(market.id)
        let updatedMarket = Market(
            id: market.id,
            name: market.name,
            price: market.price,
            itensAmount: market.productList.count,
            date: market.date,
            productList: market.productList.map { product in
                if product.id == newProduct.id {
                    return newProduct
                } else {
                    return product
                }
            },
            createdBy: market.createdBy
        )
        ref.updateChildValues(updatedMarket.toDictionary())
    }
    
    func deleteMarket(market: Market) {
        let ref = Database.database().reference().child("markets").child(market.id)
        ref.removeValue()
    }
}
