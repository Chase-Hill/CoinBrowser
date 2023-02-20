//
//  Coin.swift
//  CoinBrowser
//
//  Created by Karl Pfister on 11/23/21.
//

import Foundation

class Coin {
    let id: String
    let symbol: String
    let name: String
    
    init?(dictionary: [String: Any]) {
        guard let id = dictionary[Keys.id] as? String,
              let symbol = dictionary[Keys.symbol] as? String,
              let name = dictionary[Keys.name] as? String else {return nil}
        self.id = id
        self.symbol = symbol
        self.name = name
    }
}
