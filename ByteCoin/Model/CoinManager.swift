//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinData(_ coinManager : CoinManager, coin : CoinModel)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "DA7F1921-B2AA-4E20-931A-7FFF735D9EBD"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate : CoinManagerDelegate?
    
   
    func finalURL(currency : String) {
        let url = "\(baseURL)\(currency)?apikey=\(apiKey)"
        performRequest(with: url)
    }
    func performRequest(with urlString : String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let coin = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCoinData(self, coin: coin)
                        
                    }
                }
                
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data : Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            let coin = CoinModel(lastPrice: lastPrice)
            return coin
        }
        catch {
            print(error)
            return nil
        }
    }
    
}




//
//func performRequest(urlString : String) {
//    if let url = URL(string: urlString) {
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: url) { (data, response, error) in
//            if error != nil {
//                print(error!)
//                return
//            }
//            if let safeData = data {
//                let stringData = String(data: safeData, encoding: .utf8)
//            }
//        }
//        task.resume()
//
//    }
//
//}
