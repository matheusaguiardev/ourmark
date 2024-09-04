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
    
    func deleteMarket(market: Market) {
        let ref = Database.database().reference().child("markets").child(market.id)
        ref.removeValue()
    }
}
