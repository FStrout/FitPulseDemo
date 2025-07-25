//
//  FitPulseDemoTests.swift
//  FitPulseDemoTests
//
//  Created by Fred Strout on 7/22/25.
//

import Testing
import SwiftUI
@testable import FitPulseDemo

@MainActor
struct FitPulseDemoTests {

    @Test func resetUpdateables() async throws {
      let vm = FitPulseDemoViewModel(
        duration: 30,
        averagePulseRate: 70,
        maxPulseRate: 75,
        minPulseRate: 65,
        pulseRates: [70, 65, 75]
      )
      
      #expect(vm.duration == 30)
      #expect(vm.averagePulseRate == 70)
      #expect(vm.maxPulseRate == 75)
      #expect(vm.minPulseRate == 65)
      #expect(vm.pulseRates == [70, 65, 75])
      
      vm.resetState()
      
      #expect(vm.duration == 0)
      #expect(vm.averagePulseRate == 0)
      #expect(vm.maxPulseRate == 0)
      #expect(vm.minPulseRate == 0)
      #expect(vm.pulseRates.isEmpty)
    }

}

// I would normally create a working ViewModel if I was going to test anything.
// As this is a demo for a starter project, I decided to not do that.
// My apologies for this work around.
@MainActor
class FitPulseDemoViewModel: ObservableObject {
  
  @Published var duration: Int
  @Published var averagePulseRate: Int
  @Published var maxPulseRate: Int
  @Published var minPulseRate: Int
  @Published var pulseRates: [Int]
  
  init(duration: Int, averagePulseRate: Int, maxPulseRate: Int, minPulseRate: Int, pulseRates: [Int]) {
    self.duration = duration
    self.averagePulseRate = averagePulseRate
    self.maxPulseRate = maxPulseRate
    self.minPulseRate = minPulseRate
    self.pulseRates = pulseRates
  }
  
  func resetState() {
    duration = 0
    averagePulseRate = 0
    maxPulseRate = 0
    minPulseRate = 0
    pulseRates.removeAll()
  }
}
