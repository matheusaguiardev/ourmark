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
    let onClick: (Bool) -> Void
    let selectedColor: Color
    let unselectedColor: Color

    @State private var isSelected: Bool = false
    @Binding var color: Color
    
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

    init(
        product: Product,
        color: Binding<Color>,
        selectedColor: Color = .green,
        unselectedColor: Color = .white,
        onClick: @escaping (Bool) -> Void
    ) {
        self.product = product
        self._color = color
        self.selectedColor = selectedColor
        self.unselectedColor = Color("background")
        self.price = product.price
        self.onClick = onClick
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Nome: \(self.product.name)")
                HStack {
                    Text("Último preço:")
                    CurrencyField(value: $price)
                }
                Text("Quantidade: \(self.product.quantity) \(self.product.unity)")
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color.black)
                .padding(6)
        }
        .padding(12)
        // Muda a cor de fundo dependendo do estado de seleção
        .background(isSelected ? selectedColor : unselectedColor)
        .cornerRadius(5.0)
        .onTapGesture {
            isSelected.toggle()
            onClick(isSelected)
            color = isSelected ? selectedColor : unselectedColor
        }
    }
}

#Preview {
    ProductCell(
        product: productStub,
        color: .constant(.white),
        selectedColor: Color("selectorColor")
    ) { onClick in print("Foi selecionado: \(onClick)") }
}
