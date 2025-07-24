//
//  ContentView.swift
//  FitPulseDemo
//
//  Created by Fred Strout on 7/22/25.
//

import SwiftUI
import SmartSpectraSwiftSDK

struct MainView: View {
  
  @ObservedObject var SmartSpectra = SmartSpectraSwiftSDK.shared
  
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("It's a wonderful day in the neighborhood!")
    }
    .padding()
  }
}

#Preview {
  MainView()
}
