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
    
    @StateObject private var stateProduct = ProductViewController(product: nil)
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    init(product: Product?) {
        self.product = product
    }
    
    let quantityFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // Use a formatação numérica simples
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    var body: some View {
        Form {
            TextField("Nome do produto", text: $stateProduct.productName)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.black, lineWidth: 1)
                )
            
            CurrencyField(value: $stateProduct.price)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.black, lineWidth: 1)
                )
            HStack {
                TextField("Quantidade ou Medida", value: $stateProduct.quantity, formatter: quantityFormatter)
                    .keyboardType(.numberPad)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(.black, lineWidth: 1)
                    )
                
                Picker("", selection: $stateProduct.unitySelection) {
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
            TextField("Marca", text: $stateProduct.mark)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.black, lineWidth: 1)
                )
            Text("Observação")
            TextEditor(text: $stateProduct.detail)
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
                    
                    stateProduct.clearProduct()
                }
            }
        }.alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Confirmação"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }.onAppear {
            self.stateProduct.updateProduct(product: product)
        }
    }
    
    func saveProduct() {
        let product = Product(
            id: UUID().uuidString,
            name: stateProduct.productName,
            price: stateProduct.price,
            mark: stateProduct.mark,
            details: stateProduct.detail,
            quantity: stateProduct.quantity,
            unity: stateProduct.unitySelection,
            substitute: stateProduct.substitute,
            inCart: false
        )
        
        productRepository.addMarket(product: product)
    }
}

#Preview {
    ProductView(product: productStub)
}
