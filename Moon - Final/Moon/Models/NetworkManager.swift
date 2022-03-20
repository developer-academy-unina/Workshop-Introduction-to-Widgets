//
//  NetworkManager.swift
//  Moon
//
//  Created by Pasquale Vittoriosi for the Developer Academy on 18/02/22.
//
//


import Foundation

enum HTTPMethods: String {
    case post = "POST"
    case get = "GET"
}

enum CoinInfoError: Error, LocalizedError {
    case serverError
}

@MainActor
class NetworkManager {
    
    static var urlComponents = URLComponents(string: "https://api.coingecko.com")!
    
    
    static let jsonDecoder = JSONDecoder()
    static let jsonEncoder = JSONEncoder()
    
    private func getRequest(url: URL, method: HTTPMethods = HTTPMethods.get) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    static func getAllCoins(currency: String = Locale.current.currencyCode?.lowercased() ?? "usd", limit: Int = 10) async throws -> [Coin] {
        NetworkManager.urlComponents.path =
         "/api/v3/coins/markets"
        
        NetworkManager.urlComponents.queryItems = [
            "vs_currency": currency,
            "per_page": String(limit),
            "sparkline": "true"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        var request = URLRequest(url: NetworkManager.urlComponents.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
                
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw CoinInfoError.serverError
              }

        let coins = try NetworkManager.jsonDecoder.decode([Coin].self, from: data)
        return coins
    }
    
    static func getCoin
    (currency: String = Locale.current.currencyCode?.lowercased() ?? "usd", limit: Int = 10, coinName: String) async throws -> Coin? {
        
        return try? await NetworkManager.getAllCoins(currency: currency, limit: limit).first(where: {$0.id == coinName})
    }
    
}
