//
//  MarketView.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 29/04/24.
//

import SwiftUI
import CurrencyField

struct MarketCell: View {
    let marketInfo: Market
    @State private var price: Int
    
    init(market: Market) {
        self.marketInfo = market
        price = market.price
    }
    
    var body: some View {
        
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(marketInfo.name)
                HStack {
                    Text(self.marketInfo.date.formatDate())
                    Spacer()
                    CurrencyField(value: $price)
                        
                }
                HStack(alignment: .bottom) {
                    Text("Quantidade: \(self.marketInfo.itensAmount)")
                    Spacer()
                    Text("Criado por: \(self.marketInfo.createdBy)")
                        .font(.system(size: 12))
                }
            }
            Image(systemName: "chevron.right")
                    .foregroundColor(Color.black)
                    .padding(6)
        }.padding(15)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(.black, lineWidth: 1)
            )
    }
}

#Preview {
    MarketCell(market: marketStub)
}
