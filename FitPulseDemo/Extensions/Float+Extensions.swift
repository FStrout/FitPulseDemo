//
//  Float+Extensions.swift
//  FitPulseDemo
//
//  Created by Fred Strout on 7/24/25.
//

import Foundation

extension Float {
  func toString(_ numberOfDecimals: Int = 0) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.minimumFractionDigits = numberOfDecimals
    numberFormatter.maximumFractionDigits = numberOfDecimals
    
    return numberFormatter.string(from: NSNumber(value: self)) ?? ""
  }
}
