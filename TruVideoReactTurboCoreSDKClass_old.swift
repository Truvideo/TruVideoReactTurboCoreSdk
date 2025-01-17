//
//  TruVideoReactTurboCoreSDKClass.swift
//  truvideo-react-turbo-core-sdk
//
//  Created by mac on 16/01/2025.
//

import Foundation
import TruvideoSdk

@objc final public class TruVideoReactTurboCoreSDKClass: NSObject {
  
  @objc public func greating(_ name: String) -> String {
    return "Hello \(name)"
  }
  
  @objc public func isAuthenticated() -> Bool {
    do {
      let isAuthenticated = try TruvideoSdk.isAuthenticated()
      print("isAuthenticated", isAuthenticated)
      return isAuthenticated
    } catch let error {
      return false
    }
  }
  
  @objc public func isAuthenticationExpired()-> Bool {
    do {
      let isExpired = try TruvideoSdk.isAuthenticationExpired()
      print("isExpired", isExpired)
      return isExpired
    } catch let error {
      return false
    }
  }
  
  @objc public func generatePayload()-> String {
    do {
      let payload = try TruvideoSdk.generatePayload()
      print("generatePayload", payload)
      return payload
    } catch let error {
      return ""
    }
  }
  
  @objc public func authenticate(apiKey: String, payload: String, signature: String, externalId: String) async -> String {
    do {
      try await TruvideoSdk.authenticate(apiKey: apiKey, payload: payload, signature: signature, externalId: externalId)
      print("Success....... From iOS  authenticate")
      return "Authenticate Successfully"
    } catch {
      return "Authenticate Failed"
    }
  }
  
  @objc public func initAuthentication() async -> String {
    do {
      try await TruvideoSdk.initAuthentication()
      print("Success....... From iOS  initAuthentication")
      return "Authenticate Intialized..."
    } catch {
      return "Authenticate Failed"
    }
  }
  
  @objc public func clearAuthentication() {
    do {
      Task {
        print("Success....... From iOS  clearAuthentication")

        try TruvideoSdk.clearAuthentication()
      }
    }
  }
  
}
