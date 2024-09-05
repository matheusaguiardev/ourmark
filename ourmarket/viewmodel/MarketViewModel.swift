//
//  MarketViewModel.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 01/09/24.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftUI

class MarketViewModel: ObservableObject {
    @Published var markets: [Market] = []

    private let db = Database.database().reference()
    
    init() {
        fetchMarkets()
    }

    func fetchMarkets() {
        db.child("markets").observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            let newMarkets = self.parseMarkets(from: snapshot)
            DispatchQueue.main.async {
                self.markets = newMarkets
            }
        }
    }

    private func parseMarkets(from snapshot: DataSnapshot) -> [Market] {
        var newMarkets: [Market] = []
        for child in snapshot.children {
            if let snapshot = child as? DataSnapshot,
               let value = snapshot.value as? [String: Any] {
                if let market = createMarket(from: snapshot, value: value) {
                    newMarkets.append(market)
                }
            }
        }
        return newMarkets
    }

    private func createMarket(from snapshot: DataSnapshot, value: [String: Any]) -> Market? {
        let id = snapshot.key
        let name = value["name"] as? String ?? ""
        let price = value["price"] as? Int ?? 0
        let itensAmount = value["itensAmount"] as? Int ?? 0
        let dateInterval = value["date"] as? TimeInterval ?? 0.0
        let date = Date(timeIntervalSince1970: dateInterval)
        let createdBy = value["createdBy"] as? String ?? ""

        let productList = parseProducts(from: value["productList"] as? [[String: Any]] ?? [])

        return Market(
            id: id,
            name: name,
            price: price,
            itensAmount: itensAmount,
            date: date,
            productList: productList,
            createdBy: createdBy
        )
    }

    private func parseProducts(from productsArray: [[String: Any]]) -> [Product] {
        return productsArray.compactMap { productDict in
            let productId = productDict["id"] as? String ?? ""
            let productName = productDict["name"] as? String ?? ""
            let productPrice = productDict["price"] as? Int ?? 0
            let productQuantity = productDict["quantity"] as? Int ?? 0
            let unityString = productDict["unity"] as? String ?? "Un"
            let unity = Unity(rawValue: unityString) ?? .Un
            let mark = productDict["mark"] as? String ?? ""
            let details = productDict["details"] as? String ?? ""
            let inCart = productDict["inCart"] as? Bool ?? false

            let substitute = parseSubstitute(from: productDict["substitute"] as? [String: Any])

            return Product(
                id: productId,
                name: productName,
                price: productPrice,
                mark: mark,
                details: details,
                quantity: productQuantity,
                unity: unity,
                substitute: substitute,
                inCart: inCart
            )
        }
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
            substitute: nil,
            inCart: substituteDict["inCart"] as? Bool ?? false
        )
    }
}
