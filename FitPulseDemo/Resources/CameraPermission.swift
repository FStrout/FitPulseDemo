//
//  CameraPermission.swift
//  FitPulseDemo
//
//  Created by Fred Strout on 7/24/25.
//

import AVFoundation

class CameraPermission: ObservableObject {
  public static let shared = CameraPermission()
  @Published var isCameraAuthorized: Bool = false
  
  func requestCameraPermission() async {
    isCameraAuthorized = await AVCaptureDevice.requestAccess(for: .video)
  }
  
  func checkCameraPermission() async {
    let status = AVCaptureDevice.authorizationStatus(for: .video)
    
    switch status {
    case .authorized:
      isCameraAuthorized = true
    case .notDetermined:
      isCameraAuthorized = await AVCaptureDevice.requestAccess(for: .video)
    case .denied, .restricted:
      isCameraAuthorized = false
    @unknown default:
      isCameraAuthorized = false
    }
  }
}
