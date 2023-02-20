//
//  CoinController.swift
//  CoinBrowser
//
//  Created by Chase on 2/20/23.
//

import Foundation

class CoinController {
    
    // MARK: - Properties
    
    static var coins: [Coin] = []
    
    // MARK: - Functions
    
    static func fetchCoins(completion: @escaping (Bool) -> Void) {
        guard let baseURL = URL(string: Constants.CoinGecko.baseURL) else { return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(Constants.CoinGecko.coinPath)
        
        guard let finalURl = urlComponents?.url else { return }
        print(finalURl)
        
        URLSession.shared.dataTask(with: finalURl) { coinData, response, error in
            
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
                completion(false)
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response Status Code: \(response.statusCode)")
            }
            
            guard let data = coinData else { return }
            do {
                
                if let topLevel = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [[String : Any]] {
                    for coinDictionary in topLevel {
                        guard let parsedCoin = Coin(dictionary: coinDictionary) else { return }
                        coins.append(parsedCoin)
                    }
                    completion(true)
                }
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        } .resume()
    }
}
