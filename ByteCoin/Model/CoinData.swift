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
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        formatter.generatesDecimalNumbers = true
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: last)) ?? "Error"

    }

    
}
