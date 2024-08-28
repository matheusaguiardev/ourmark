//
//  MarketView.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 29/04/24.
//

import SwiftUI

struct MarketCell: View {
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
        }.padding(15)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(.black, lineWidth: 1)
            ).padding(30)
    }
}

#Preview {
    MarketCell(market: marketStub)
}
