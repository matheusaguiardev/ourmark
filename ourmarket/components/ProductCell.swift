//
//  ProductCell.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 30/04/24.
//

import CurrencyField
import SwiftUI

struct ProductCell: View {
    let product: Product
    let color: Color
    
    init(product: Product, color: Color) {
        self.product = product
        self.color = color
        self.price = product.price
    }
    
    @State private var chosenLocale = Locale(identifier: "pt_BR")
    @State private var price: Int

    private var formatter: NumberFormatter {
        let fmt = NumberFormatter()
        fmt.numberStyle = .currency
        fmt.minimumFractionDigits = 2
        fmt.maximumFractionDigits = 2
        fmt.locale = chosenLocale
        return fmt
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Nome: \(self.product.name)")
                //Text("Ultimo preço: \(self.product.price.toCurrency())")
                CurrencyField(value: $price)
                Text("Quantidade: \(self.product.quantity) \(self.product.unity)")
            }
            Spacer()
            Image(systemName: "chevron.right")
                    .foregroundColor(Color.black)
                    .padding(6)
        }.padding(30)
            .background(self.color)
    }
}

#Preview {
    ProductCell(
        product: productStub,
        color: Color.green.opacity(0.3)
    )
}
