//
//  ProductViewController.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 05/09/24.
//

import SwiftUI

class ProductViewController: ObservableObject {
    @Published var productName: String = ""
    @Published var price: Int = 0
    @Published var quantity: Int = 1
    @Published var mark: String = ""
    @Published var substitute: Product?
    @Published var detail: String = ""
    @Published var unitySelection = Unity.Un
    
    init(product: Product?) {
        self.productName = product?.name ?? ""
        self.price = product?.price ?? 0
        self.quantity = product?.quantity ?? 1
        self.mark = product?.mark ?? ""
        self.substitute = product?.substitute
        self.detail = product?.details ?? ""
        self.unitySelection = product?.unity ?? Unity.Un
    }
    
    func updateProduct(product: Product?) {
        self.productName = product?.name ?? ""
        self.price = product?.price ?? 0
        self.quantity = product?.quantity ?? 1
        self.mark = product?.mark ?? ""
        self.substitute = product?.substitute
        self.detail = product?.details ?? ""
        self.unitySelection = product?.unity ?? Unity.Un
    }
    
    func clearProduct() {
        self.productName = ""
        self.price = 0
        self.quantity = 1
        self.mark = ""
        self.substitute = nil
        self.detail = ""
        self.unitySelection = Unity.Un
    }
}
