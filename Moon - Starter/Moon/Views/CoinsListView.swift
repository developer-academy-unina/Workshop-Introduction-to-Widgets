//
//  CoinsListView.swift
//  Moon
//
//  Created by Pasquale Vittoriosi for the Developer Academy on 18/02/22.
//
//


import SwiftUI

struct CoinsListView: View {
    
    @State var coins = [Coin]()
    
    var body: some View {
        NavigationView {
            if coins.isEmpty {
                ProgressView("Fatching all Coins...")
            } else {
                List {
                    ForEach(coins) { coin in
                        NavigationLink(destination: CoinDetailView(coin: coin)) {
                            CoinRowView(coin: coin)
                                .padding([.top, .bottom])
                        }
                    }
                }
                .refreshable {
                    try? coins = await NetworkManager.getAllCoins()
                }
                .navigationTitle("Coins")
            }
        }.task {
            try? coins = await NetworkManager.getAllCoins()
        }
    }
}

struct CoinsList_Previews: PreviewProvider {
    static var previews: some View {
        CoinsListView(coins: [Coin.previewData])
    }
}

