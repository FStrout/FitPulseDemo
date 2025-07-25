//
//  ContentView.swift
//  FitPulseDemo
//
//  Created by Fred Strout on 7/22/25.
//

import AVFoundation
import SwiftUI
import SmartSpectraSwiftSDK

struct MainView: View {
  @ObservedObject var cameraPermission = CameraPermission.shared
  @ObservedObject var smartSpectraSDK = SmartSpectraSwiftSDK.shared
  @ObservedObject var smartSpectraVP = SmartSpectraVitalsProcessor.shared
  
  @State private var isMonitoringEnabled: Bool = false
  @State var tods: [Date] = []
  @State private var durations: [Presage_Physiology_MeasurementWithConfidence] = []
  @State var hasCameraPermission: Bool = false
  
  init() {
    let smartSpectraApiKey = LocalKeys.SmartSpectraApiKey
    
    smartSpectraSDK.setApiKey(smartSpectraApiKey)
    smartSpectraSDK.setSmartSpectraMode(.continuous)
    Task {
      await CameraPermission.shared.checkCameraPermission()
    }
  }
  
  var body: some View {
    VStack {
      HStack {
        Text("FitPulseDemo")
          .font(.largeTitle)
          .bold()
        
        Spacer()
      }
      .padding()
      
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
  
  var loadedView: some View {
    VStack {
      ContinuousVitalsPlotView()
      
      HStack {
        Text("Test Duration:")
        
        Spacer()
        
        Text("\(smartSpectraSDK.metricsBuffer?.pulse.rate.last?.time.toString() ?? "0")")
      }
      
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
      .padding()
      
      List {
        ForEach(0..<durations.count, id: \.self) { idx in
          listView(idx)
        }
      }
      
      Spacer()
    }
    .padding(.horizontal)
  }
  
  func listView(_ idx: Int) -> some View {
    VStack(alignment: .leading) {
      Text("\(tods[idx].usDateTime)")
        .bold()
      HStack(alignment: .center) {
        Text("Duration: \(durations[idx].time.toString()) seconds")
        
        Spacer()
        
        Text("\(durations[idx].value.toString()) BPM")
          .bold()
      }
    }
  }
  
  func startVitalsMonitoring() {
    smartSpectraVP.startProcessing()
    smartSpectraVP.startRecording()
  }
  
  func stopVitalsMonitoring() {
    smartSpectraVP.stopProcessing()
    smartSpectraVP.stopRecording()
    if let metricsBuffer = smartSpectraSDK.metricsBuffer, let lastRate = metricsBuffer.pulse.rate.last {
      durations.append(lastRate)
      tods.append(.now)
    }
    smartSpectraSDK.metricsBuffer = nil
  }
}

#Preview {
  MainView()
}
