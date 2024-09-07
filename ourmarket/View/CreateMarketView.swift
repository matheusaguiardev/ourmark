//
//  AddMarketModalView.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 03/09/24.
//

import SwiftUI

struct CreateMarketView: View {
    @StateObject var productViewModel = ProductViewModel()
    @Binding var showModal: Bool
    @State private var marketName: String = ""
    @State private var marketPrice: String = ""
    var owner: String
    var onSave: (Market) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Nome do supermercado")) {
                    TextField("Nome", text: $marketName)
                }
                
                Text("Produtos para adicionar nesse mercado!")
                List(productViewModel.products) { product in
                    ProductCell(
                        product: product,
                        isSelected: Binding<Bool>(
                            get: { product.inCart },
                            set: { value in product.inCart = value }
                        ),
                        color: .constant(.black),
                        selectedColor: Color("selectorColor")
                    ) { selected in
                        product.inCart = selected
                        productViewModel.putInMarketCart(product: product)
                    }
                }
            }
            .navigationTitle("Adicionar Mercado")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        showModal = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        let productList = productViewModel.products.filter { product in product.inCart }
                        
                        let newMarket = Market(
                            id: UUID().uuidString,
                            name: marketName,
                            price: productViewModel.sumPrice(productList),
                            itensAmount: productList.count,
                            date: Date(),
                            productList: productList,
                            createdBy: owner
                        )
                        onSave(newMarket)
                        showModal = false
                    }
                }
            }
        }
    }
}

#Preview {
    CreateMarketView(showModal: .constant(true), owner: "João") { market in print(market) }
}

