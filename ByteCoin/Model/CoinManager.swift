//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    var delegate: CoinManagerDelegate? {get set}
    func didUpdatePrice(_ coinManager: CoinManager, coinData: CoinData)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func getCoinPrice(for currency: String) {
        print(currency)
        let url = URL(string: baseURL + currency)
        performRequest(with: url)
    }
    
    func performRequest(with url: URL?) {
        if let url = url { //1. unwrap URL
            let session = URLSession(configuration: .default) //2. Create a URLSession
            
            //3. Give the session a task, give the task a closure
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let data = data {
                    if let last = self.parseJSON(data) {
                        self.delegate?.didUpdatePrice(self, coinData: last) // passes data to VC via delegate pattern
                    }
                }
            }
            task.resume() //4. Start the task
        }
    } // end perform request

    
    /// Parse JSON data into a CoinData instance
    func parseJSON(_ coinData: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(CoinData.self, from: coinData)
            let last = decodeData.last
            
            return CoinData(last: last)
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }

}
