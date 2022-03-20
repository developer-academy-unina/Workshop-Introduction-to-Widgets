//
//  ChartView.swift
//  BTCTracker
//
//  Created by Pasquale Vittoriosi for the Developer Academy on 18/02/22.
//
//


import SwiftUI

struct ChartView: View {
    
    let coin: Coin
    
    var body: some View {
    
        let data = coin.sparklineIn7d.price
        
        GeometryReader { proxy in
            Path { path in
                for index in data.indices {
                    let xPos = proxy.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = (data.max() ?? 0) - (data.min() ?? 0)
                    let yPos = (1 - CGFloat((data[index] - (data.min() ?? 0)) / yAxis)) * proxy.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x: xPos, y:yPos))
                    }
                    path.addLine(to: CGPoint(x: xPos, y:yPos))
                }
            }
            .stroke(coin.priceChangePercentage24h > 0 ? Color.green: Color.red, style: StrokeStyle(lineWidth: CGFloat(2)))
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: Coin.previewData)
    }
}
