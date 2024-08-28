//
//  MarketView.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 29/04/24.
//

import SwiftUI

struct MarketView: View {
    let marketInfo: Market
    
    init(market: Market) {
        self.marketInfo = market
    }
    
    var body: some View {
        
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("Mix Mateus")
                HStack {
                    Text(self.marketInfo.date.formatDate())
                    Spacer()
                    Text(self.marketInfo.price.toCurrency())
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
        }.padding(30)
    }
}

#Preview {
    MarketView(market: marketStub)
}
