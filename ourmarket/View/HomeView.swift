//
//  HomeView.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 29/04/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
        }
        .navigationTitle("OurMarket")
        .padding()
    }
}

#Preview {
    HomeView()
}
