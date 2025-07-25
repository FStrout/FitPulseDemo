//
//  Date+Extensions.swift
//  FitPulseDemo
//
//  Created by Fred Strout on 7/24/25.
//

import Foundation

extension Date {
  var usDateTime: String {
    return self.formatted(date: .abbreviated, time: .shortened)
  }
}
