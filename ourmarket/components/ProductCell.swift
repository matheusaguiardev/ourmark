//
//  ProductCell.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 30/04/24.
//

import SwiftUI

struct ProductCell: View {
    let product: Product
    let color: Color
    
    init(product: Product, color: Color) {
        self.product = product
        self.color = color
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Nome: \(self.product.name)")
                Text("Ultimo preço: \(self.product.price.toCurrency())")
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
