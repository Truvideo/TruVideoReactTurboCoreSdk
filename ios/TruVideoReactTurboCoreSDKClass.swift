//
//  TruVideoReactTurboCoreSDKClass 2.swift
//  Pods
//
//  Created by mac on 17/01/2025.
//

import Foundation
import TrueVideo
import React

@objc final public class TruVideoReactTurboCoreSDKClass: NSObject {
  
  private var isConfigured = false
  
  @objc public func greating(_ name: String) -> String {
    return "Hello \(name)"
  }
  
  // Add configuration method
  @objc public func configure(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    if isConfigured {
      resolve("Already configured")
      return
    }
    
    let truVideoOptions = TruVideoOptions()
    TruvideoSdk.configure(with: truVideoOptions)
    isConfigured = true
    print("[TruVideoSDK] SDK configured successfully")
    resolve("SDK configured successfully")
  }
  
  // Ensure SDK is configured before operations
  private func ensureConfigured() {
    if !isConfigured {
      let truVideoOptions = TruVideoOptions()
      TruvideoSdk.configure(with: truVideoOptions)
      isConfigured = true
      print("[TruVideoSDK] Auto-configured SDK")
    }
  }
  
  @objc public func isAuthenticated(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    ensureConfigured()
    let isAuthenticated = TruvideoSdk.isAuthenticated
    print("[TruVideoSDK] isAuthenticated: \(isAuthenticated)")
    resolve(isAuthenticated)
  }
  
  @objc public func isAuthenticationExpired(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    ensureConfigured()
    do {
      let isExpired = try TruvideoSdk.isAuthenticationExpired()
      print("[TruVideoSDK] isAuthenticationExpired: \(isExpired)")
      resolve(isExpired)
    } catch let error {
      print("[TruVideoSDK] isAuthenticationExpired error: \(error.localizedDescription)")
      reject("EXPIRED_CHECK_FAILED", "Failed to check authentication expiration: \(error.localizedDescription)", error)
    }
  }
  
  @objc public func generatePayload(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    ensureConfigured()
    do {
      let payload = try TruvideoSdk.generatePayload()
      print("[TruVideoSDK] generatePayload: \(payload)")
      resolve(payload)
    } catch let error {
      print("[TruVideoSDK] generatePayload error: \(error.localizedDescription)")
      reject("PAYLOAD_GENERATION_FAILED", "Failed to generate payload: \(error.localizedDescription)", error)
    }
  }
  
  @objc public func authenticate(apiKey: String, payload: String, signature: String, externalId: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    ensureConfigured()
    
    print("[TruVideoSDK] authenticate called with apiKey: \(apiKey), externalId: \(externalId)")
    
    Task {
      do {
        try await TruvideoSdk.authenticate(apiKey: apiKey, payload: payload, signature: signature, externalId: externalId)
        print("[TruVideoSDK] authenticate success")
        resolve("Authenticate Successfully")
      } catch let error {
        let errorMessage = "Authentication failed: \(error.localizedDescription)"
        print("[TruVideoSDK] authenticate error: \(errorMessage)")
        
        // Determine error code based on error type
        let errorCode: String
        if error.localizedDescription.lowercased().contains("configuration") ||
           error.localizedDescription.lowercased().contains("not configured") {
            errorCode = "CONFIGURATION_REQUIRED"
        } else if error.localizedDescription.lowercased().contains("credential") ||
                  error.localizedDescription.lowercased().contains("invalid") ||
                  error.localizedDescription.lowercased().contains("failed") {
            errorCode = "AUTHENTICATION_FAILED"
        } else {
            errorCode = "AUTHENTICATION_ERROR"
        }
        
        reject(errorCode, errorMessage, error)
      }
    }
  }
  
  @objc public func initAuthentication(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    ensureConfigured()
    
    print("[TruVideoSDK] initAuthentication called")
    
    Task {
      do {
        try await TruvideoSdk.initAuthentication()
        print("[TruVideoSDK] initAuthentication success")
        resolve("Init Authentication Successfully")
      } catch let error {
        let errorMessage = "Init authentication failed: \(error.localizedDescription)"
        print("[TruVideoSDK] initAuthentication error: \(errorMessage)")
        reject("INIT_AUTHENTICATION_FAILED", errorMessage, error)
      }
    }
  }
  
  @objc public func clearAuthentication(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    ensureConfigured()
    
    print("[TruVideoSDK] clearAuthentication called")
    
    Task {
      do {
        try TruvideoSdk.clearAuthentication()
        print("[TruVideoSDK] clearAuthentication success")
        resolve("Clear Authentication Successfully")
      } catch let error {
        let errorMessage = "Clear authentication failed: \(error.localizedDescription)"
        print("[TruVideoSDK] clearAuthentication error: \(errorMessage)")
        reject("CLEAR_AUTHENTICATION_FAILED", errorMessage, error)
      }
    }
  }
}
