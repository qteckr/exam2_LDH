//
//  Int.swift
//  exam2
//
//  Created by Qtec on 2022/10/19.
//

import Foundation

extension Int {
    
    func toDecimal() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        
        return formatter.string(from: NSNumber(integerLiteral: self)) ?? String(self)
    }
}
