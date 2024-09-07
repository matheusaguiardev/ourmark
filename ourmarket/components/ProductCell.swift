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

    @Binding var isSelected: Bool
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
        isSelected: Binding<Bool>,
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
        self._isSelected = isSelected
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(self.product.name)").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                HStack {
                    Text("Último preço:")
                    CurrencyField(value: $price).disabled(true)
                }
                Text("Quantidade: \(self.product.quantity) \(self.product.unity)")
            }
            Spacer()
            Image(systemName: "chevron.right")
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
        isSelected: Binding<Bool>(
            get: { false }, // Retorna o valor inicial falso
            set: { _ in }   // Não faz nada no mock, já que não precisa alterar o valor
        ),
        color: .constant(.white),
        selectedColor: Color("selectorColor")
    ) { onClick in print("Foi selecionado: \(onClick)") }
}
