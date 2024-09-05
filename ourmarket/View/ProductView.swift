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
    @State private var price: Int
    @State private var quantity: Int? = nil
    @State private var mark: String
    @State private var substitute: String
    @State private var detail: String
    @State private var unitySelection = Unity.Un
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    init(product: Product?) {
        self.product = product
        self._productName = State(initialValue: self.product?.name ?? "")
        self._price = State(initialValue: self.product?.price ?? 0)
        self._quantity = State(initialValue: self.product?.quantity)
        self._mark = State(initialValue: self.product?.mark ?? "")
        self._substitute = State(initialValue: self.product?.substitute?.name ?? "")
        self._unitySelection = State(initialValue: self.product?.unity ?? Unity.Un)
        self._detail = State(initialValue: self.product?.details ?? "")
    }
    
    var body: some View {
        Form {
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
           
            QuantityView(quantity: $quantity, unitySelection: $unitySelection)
            
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
        }.navigationTitle("Produto")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Salvar") {
                    saveProduct()
                    
                    alertMessage = "Produto salvo com sucesso!"
                    showingAlert = true
                    
                    productName = ""
                    price = 0
                    quantity = 0
                    mark = ""
                    detail = ""
                }
            }
        }.alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Confirmação"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private struct QuantityView : View {
        @Binding var quantity: Int?
        @Binding var unitySelection: Unity
        
        var body: some View {
            HStack {
                TextField("Quantidade ou Medida", value: $quantity, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(.black, lineWidth: 1)
                    )
                Picker("", selection: $unitySelection) {
                    ForEach(Unity.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.black, lineWidth: 1)
                )
            }
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
            substitute: nil,
            inCart: false
        )
        
        productRepository.addMarket(product: product)
    }
}

#Preview {
    ProductView(product: productStub)
}
