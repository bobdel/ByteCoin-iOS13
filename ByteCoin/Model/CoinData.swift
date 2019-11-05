//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Robert DeLaurentis on 11/5/19.
//  Copyright © 2019 Robert DeLaurentis. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    
    var last: Double
    
    var lastString: String {
        return String(format: "%.2f", last)
    }

    
}
