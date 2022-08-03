//
//  CoinRowView.swift
//  Moon
//
//  Created by Pasquale Vittoriosi for the Developer Academy on 18/02/22.
//
//


import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    
    var body: some View {
        HStack {
            AsyncImage(url: coin.image) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            .padding(.trailing)
            Text(coin.name)
                .bold()
            Spacer()
            Text(String(coin.currentPrice.formatted(.currency(code: Locale.current.currencyCode ?? "usd"))))
        }
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: Coin.previewData)
    }
}
