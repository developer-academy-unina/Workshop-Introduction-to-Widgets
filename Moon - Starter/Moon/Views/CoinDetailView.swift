//
//  CoinDetailView.swift
//  Moon
//
//  Created by Pasquale Vittoriosi for the Developer Academy on 18/02/22.
//
//


import SwiftUI

struct CoinDetailView: View {
    
    let coin: Coin
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(coin.name)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(coin.symbol)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                }
                .minimumScaleFactor(0.5)
                Spacer()
                Text(String(format: "%.02f%%", coin.priceChangePercentage24h))
                    .bold()
                    .foregroundColor(coin.priceChangePercentage24h > 0 ? .green : .red)
                    .minimumScaleFactor(0.25)
            }
            Spacer()
            ChartView(coin: coin)
                .frame(maxHeight: 200)
            Spacer()
            Text(String(coin.currentPrice.formatted(.currency(code: Locale.current.currencyCode ?? "usd"))))
                .bold()
                .font(.title)
                .minimumScaleFactor(0.5)
        }
        .navigationTitle(coin.name)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(coin: Coin.previewData)
    }
}
