//
//  ProductRepository.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 03/09/24.
//

import FirebaseDatabase

class ProductsRepository {
    func addMarket(product: Product) {
        let ref = Database.database().reference().child("products").child(product.id)
        ref.setValue(product.toDictionary())
    }

    func updateMarket(product: Product) {
        let ref = Database.database().reference().child("products").child(product.id)
        ref.updateChildValues(product.toDictionary())
    }
    
    func deleteMarket(product: Product) {
        let ref = Database.database().reference().child("products").child(product.id)
        ref.removeValue()
    }
}
