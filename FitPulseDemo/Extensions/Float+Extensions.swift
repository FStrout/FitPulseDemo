//
//  Float+Extensions.swift
//  FitPulseDemo
//
//  Created by Fred Strout on 7/24/25.
//

import Foundation

extension Float {
  
  func toDouble() -> Double {
    return Double(self)
  }
  
  func toInt() -> Int {
    return Int(self.rounded())
  }
}
