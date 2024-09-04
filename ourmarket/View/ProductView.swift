//
//  ProductView.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 30/04/24.
//

import SwiftUI
import CurrencyField

struct ProductView: View {
    let product: Product?
    private let productRepository = ProductsRepository()
    
    @State private var productName: String
    @State private var price: Int = 0
    @State private var quantity: Int? = nil
    @State private var mark: String
    @State private var substitute: String
    @State private var detail: String
    @State private var unitySelection = Unity.Un
    
    init(product: Product?) {
        self.product = product
        _productName = State(initialValue: self.product?.name ?? "")
        _price = State(initialValue: self.product?.price ?? 0)
        _quantity = State(initialValue: self.product?.quantity ?? 0)
        _mark = State(initialValue: self.product?.mark ?? "")
        _substitute = State(initialValue: self.product?.substitute?.name ?? "")
        _unitySelection = State(initialValue: self.product?.unity ?? Unity.Un)
        _detail = State(initialValue: self.product?.details ?? "")
    }
    
    var body: some View {
        VStack {
            TextField("Nome do produto", text: $productName)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.black, lineWidth: 1)
                )
            
            CurrencyField(value: $price)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.black, lineWidth: 1)
                )
            HStack() {
                TextField("Quantidade ou Medida", value: $quantity, formatter: NumberFormatter())
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(.black, lineWidth: 1)
                    )
                Picker("", selection: $unitySelection) {
                    ForEach(Unity.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }.overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.black, lineWidth: 1)
                )
            }
            
            TextField("Marca", text: $mark)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.black, lineWidth: 1)
                )
            
            Text("Observação")
            TextEditor(text: $detail)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.black, lineWidth: 1)
                )
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        }.padding()
        
        Spacer()
        Button(action: saveProduct) {
            Text("Salvar")
        }
    }
    
    func saveProduct() {
        let product = Product(
            id: UUID().uuidString,
            name: _productName.wrappedValue,
            price: _price.wrappedValue,
            mark: _mark.wrappedValue,
            details: _detail.wrappedValue,
            quantity: _quantity.wrappedValue ?? 0,
            unity: _unitySelection.wrappedValue,
            substitute: nil

        )
        
        productRepository.addMarket(product: product)
    }
}

#Preview {
    ProductView(product: productStub)
}
