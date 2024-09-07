//
//  ProductViewModel.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 03/09/24.
//
import Foundation
import Firebase
import FirebaseDatabase
import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var marketProducts: [Product] = []

    private let db = Database.database().reference()
    
    init() {
        fetchProducts()
    }
    
    func putInMarketCart(product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index] = product
        }
    }
    
    func sumPrice(_ productList: [Product]) -> Int {
            let priceSum = productList.reduce(0) { total, product in
                total + product.price
            }
        return priceSum
    }

    func fetchProducts() {
        db.child("products").observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            let newProducts = self.parseProducts(from: snapshot)
            DispatchQueue.main.async {
                self.products = newProducts
            }
        }
    }
    
    func fetchProductsByMarketId(marketId: String) {
        db.child("markets").child(marketId).child("products").observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            let newProducts = self.parseProducts(from: snapshot)
            DispatchQueue.main.async {
                self.marketProducts = newProducts
            }
        }
    }

    private func parseProducts(from snapshot: DataSnapshot) -> [Product] {
        var newProducts: [Product] = []
        for child in snapshot.children {
            if let snapshot = child as? DataSnapshot,
               let value = snapshot.value as? [String: Any] {
                if let product = createProduct(from: snapshot, value: value) {
                    newProducts.append(product)
                }
            }
        }
        return newProducts
    }

    private func createProduct(from snapshot: DataSnapshot, value: [String: Any]) -> Product? {
        let id = value["id"] as? String ?? UUID().uuidString
        let name = value["name"] as? String ?? ""
        let price = value["price"] as? Int ?? 0
        let quantity = value["quantity"] as? Int ?? 0
        let unityString = value["unity"] as? String ?? "Un"
        let unity = Unity(rawValue: unityString) ?? .Un
        let mark = value["mark"] as? String ?? ""
        let details = value["details"] as? String ?? ""
        let inCart = value["inCart"] as? Bool ?? false
        let substitute = parseSubstitute(from: value["substitute"] as? [String: Any])

        return Product(
            id: id,
            name: name,
            price: price,
            mark: mark,
            details: details,
            quantity: quantity,
            unity: unity,
            substitute: substitute,
            inCart: inCart
        )
    }

    private func parseSubstitute(from substituteDict: [String: Any]?) -> Product? {
        guard let substituteDict = substituteDict else { return nil }
        return Product(
            id: substituteDict["id"] as? String ?? "",
            name: substituteDict["name"] as? String ?? "",
            price: substituteDict["price"] as? Int ?? 0,
            mark: substituteDict["mark"] as? String ?? "",
            details: substituteDict["details"] as? String ?? "",
            quantity: substituteDict["quantity"] as? Int ?? 0,
            unity: Unity(rawValue: substituteDict["unity"] as? String ?? "Un") ?? .Un,
            substitute: nil, // Evitar recursão infinita
            inCart: substituteDict["inCart"] as? Bool ?? false
        )
    }
}
