//
//  HomeView.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 29/04/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = MarketViewModel()
    @State private var showModal = false
    
    private let marketRepository = MarketRepository()
    
    var owner: String
    
    var body: some View {
        NavigationStack {
            List(viewModel.markets) { market in
                NavigationLink(destination: MarketView(market: market)) {
                   MarketCell(market: market)
                }
            }
            .navigationTitle("OurMarket")
            .navigationBarTitleDisplayMode(.inline) // Ajusta a exibição do título
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProductView(product: nil)) {
                        Text("Produtos")
                            .font(.headline)
                    }
                }
            }
            .sheet(isPresented: $showModal) {
                CreateMarketView(showModal: $showModal, owner: self.owner) { market in
                    marketRepository.addMarket(market: market)
                }
            }
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showModal.toggle()
                        }) {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        }
                        .padding()
                    }
                }
                , alignment: .bottomTrailing
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView(owner: "Usuário")
}
