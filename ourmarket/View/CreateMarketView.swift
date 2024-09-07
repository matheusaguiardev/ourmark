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
                        color: .constant(.black),
                        selectedColor: Color("selectorColor")
                    ) { selected in
                        product.inCart = selected
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
                        
                        
                        let newMarket = Market(
                            id: UUID().uuidString,
                            name: marketName,
                            price: productViewModel.sumPrice(),
                            itensAmount: productViewModel.products.count,
                            date: Date(),
                            productList: productViewModel.products,
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

