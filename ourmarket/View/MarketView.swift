//
//  MarketView.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 05/09/24.
//

import SwiftUI
import CurrencyField

struct MarketView: View {
    let market: Market 
    private var marketRepository = MarketRepository()
    @StateObject private var productViewModel = ProductViewModel()
    
    @State private var price: Int
    
    init(market: Market) {
        self.market = market
        self.price = market.price
    }
    var body: some View {
        VStack {
            HStack {
                Text(market.name)
                Text(market.date.formatDate())
            }
            HStack {
                Text("Total calculado")
                CurrencyField(value: $price)
            }
            
            List(productViewModel.marketProducts) { product in
                
                ProductCell(
                    product: product,
                    isSelected: Binding<Bool>(
                        get: { product.inCart },
                        set: { value in product.inCart = value }
                    ),
                    color: .constant(.white),
                    selectedColor: Color("selectorColor")
                ) { selected in
                    product.inCart = selected
                    
                    marketRepository.updateProducts(market: market, newProduct: product)
                }
            }
        }.onAppear {
            productViewModel.fetchProductsByMarketId(marketId: market.id)
        }
    }
}

#Preview {
    MarketView(market: marketStub)
}
