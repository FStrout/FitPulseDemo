//
//  ContentView.swift
//  FitPulseDemo
//
//  Created by Fred Strout on 7/22/25.
//

import AVFoundation
import SwiftUI
import SmartSpectraSwiftSDK

struct Measurement: Hashable {
  var time: Date
  var duration: Int
  var measurement: Presage_Physiology_MeasurementWithConfidence
  var minPulseRate: Int
  var maxPulseRate: Int
  var averagePulseRate: Int
}

struct MainView: View {
  @ObservedObject var cameraPermission = CameraPermission.shared
  @ObservedObject var smartSpectraSDK = SmartSpectraSwiftSDK.shared
  @ObservedObject var smartSpectraVP = SmartSpectraVitalsProcessor.shared
  
  @State private var hasCameraPermission: Bool = false
  
  @State private var isMonitoringEnabled: Bool = false
  @State private var measurements: [Measurement] = []
  
  @State var duration: Int = 0
  @State var averagePulseRate: Int = 0
  @State var maxPulseRate: Int = 0
  @State var minPulseRate: Int = 0
  @State var pulseRates: [Int] = []
  
  init() {
    let smartSpectraApiKey = LocalKeys.physiologyApiKey
    
    smartSpectraSDK.setApiKey(smartSpectraApiKey)
    smartSpectraSDK.setSmartSpectraMode(.continuous)
    
    Task {
      await CameraPermission.shared.checkCameraPermission()
    }
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      HStack {
        Text("FitPulseDemo")
          .font(.largeTitle)
          .bold()
        
        Spacer()
      }
      .padding(.horizontal)
      
      if hasCameraPermission {
        loadedView
      } else {
        loadingView
      }
    }
    .onReceive(cameraPermission.$isCameraAuthorized) { _ in
      hasCameraPermission = cameraPermission.isCameraAuthorized
    }
  }
  
  var loadingView: some View {
    VStack(alignment: .leading) {
      Text("Camera Permissions Required.")
        .font(.title2)
      
      Text("Fit Pulse requires camera access to function.")
        .font(.caption)
      
      Spacer()
      
      Text("To continue, please use the button below to open the application settings and toggle on the camera permissions.")
      HStack {
        Spacer()
        Button {
          if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
          }
        } label: {
          Text("Request Camera Access")
        }
        .padding(.horizontal)
        .frame(height: 40)
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(8)
        .padding()
        Spacer()
      }
      .padding(.bottom, 48)
      Spacer()
    }
    .padding()
  }
  
  func testDetails(description: String, value: Int) -> some View {
    VStack {
      Text(description)
        .font(.footnote)
      Text("\(value)")
        .font(.footnote)
        .bold()
    }
  }
  
  var loadedView: some View {
    VStack(spacing: 8) {
      ContinuousVitalsPlotView()
      
      HStack {
        Text("Test Duration")
        Spacer()
        Text("\(duration) sec")
      }
      .padding(.vertical)
      
      HStack {
        Text("Pulse Rate (BPM)")
        Spacer()
      }
      HStack(spacing: 4) {
        testDetails(description: "Min", value: minPulseRate)
        Spacer()
        testDetails(description: "Max", value: maxPulseRate)
        Spacer()
        testDetails(description: "Avg", value: averagePulseRate)
      }
      .padding([.horizontal, .bottom])
      
      Button {
        isMonitoringEnabled ? stopVitalsMonitoring() : startVitalsMonitoring()
        isMonitoringEnabled.toggle()
      } label: {
        Text(isMonitoringEnabled ? "Stop" : "Start")
      }
      .frame(width: 120, height: 40)
      .foregroundColor(.white)
      .background(Color.blue)
      .cornerRadius(8)
      .padding(.horizontal)
      
      List {
        ForEach(measurements, id: \.self) { measurement in
          listView(measurement)
        }
      }
      .padding(.horizontal, -16)
      
      Spacer()
    }
    .padding(.horizontal)
    .onReceive(smartSpectraSDK.$metricsBuffer) { metricsBuffer in
      guard isMonitoringEnabled, let metrics = metricsBuffer, metrics.isInitialized else { return }
      
      let rates = metrics.pulse.rate.map { $0.value.toInt() }
      
      rates.forEach { pulseRates.append($0) }
      
      if !rates.isEmpty, let last = metrics.pulse.rate.last {
        minPulseRate = pulseRates.min() ?? 0
        maxPulseRate = pulseRates.max() ?? 0
        averagePulseRate = pulseRates.reduce(0, +) / pulseRates.count
        duration = last.time.toInt()
      }
    }
  }
  
  func listView(_ measurement: Measurement) -> some View {
    VStack(alignment: .leading) {
      HStack {
        Text("\(measurement.time.usDateTime)")
          .bold()
        Spacer()
        Text("\(measurement.duration) sec")
      }
      HStack(alignment: .center) {
        Spacer()
          .frame(width: 16)
        testDetails(description: "Min", value: measurement.minPulseRate)
        Spacer()
        testDetails(description: "Max", value: measurement.maxPulseRate)
        Spacer()
        testDetails(description: "Avg", value: measurement.averagePulseRate)
        Spacer()
          .frame(width: 16)
      }
    }
  }
  
  private func startVitalsMonitoring() {
    smartSpectraVP.startProcessing()
    smartSpectraVP.startRecording()
  }
  
  private func stopVitalsMonitoring() {
    smartSpectraVP.stopProcessing()
    smartSpectraVP.stopRecording()
    if let metricsBuffer = smartSpectraSDK.metricsBuffer,
       let lastRate = metricsBuffer.pulse.rate.last
    {
      measurements.append(
        Measurement(
          time: .now,
          duration: duration,
          measurement: lastRate,
          minPulseRate: minPulseRate,
          maxPulseRate: maxPulseRate,
          averagePulseRate: averagePulseRate
        )
      )
    }
    print("Pulse Rates: \(pulseRates)")
  }
}

#Preview {
  MainView()
}

#Preview {
  MainView()
    .preferredColorScheme(.dark)
}
