//
//  TruVideoReactTurboCoreSDKClass 2.swift
//  Pods
//
//  Created by mac on 17/01/2025.
//


import Foundation
import TruvideoSdk
import React
@objc final public class TruVideoReactTurboCoreSDKClass: NSObject {
  
  @objc public func greating(_ name: String) -> String {
    return "Hello \(name)"
  }
  
  @objc public func isAuthenticated(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    let isAuthenticated = TruvideoSdk.isAuthenticated
 //     print("isAuthenticated", isAuthenticated)
    resolve(isAuthenticated)
  }
  
  @objc public func isAuthenticationExpired(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    do {
      let isExpired = try TruvideoSdk.isAuthenticationExpired()
    //  print("isExpired", isExpired)
      resolve(isExpired)
    } catch _ {
      resolve(false)
    }
  }
  
  @objc public func generatePayload(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock){
    do {
      let payload = try TruvideoSdk.generatePayload()
  //    print("generatePayload", payload)
      resolve(payload)
    } catch let error {
      reject("Failed_payload","Failed payload",error)
    }
  }
  
  @objc public func authenticate(apiKey: String, payload: String, signature: String, externalId: String,resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock)  {
    do {
      Task {
        try await TruvideoSdk.authenticate(apiKey: apiKey, payload: payload, signature: signature, externalId: externalId)
  //      print("Success....... From iOS  authenticate")
        resolve("Authenticate Successfully")
      }
    }catch let error{
        reject("Authenticate","Authenticate Failed", NSError(domain: "Authenticate Failed", code: 400))
    }
  }
  
  @objc public func initAuthentication(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock)  {
    do {
      Task {
        try await TruvideoSdk.initAuthentication()
          resolve("Authenticate Successfully")
      }
    }catch let error{
        reject("Failed_InitAuthenticate","Failed InitAuthenticate", error)
    }
  }
  
  @objc public func clearAuthentication(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock)  {
    do {
      Task {
 //       print("Success....... From iOS  clearAuthentication")

        try TruvideoSdk.clearAuthentication()
        resolve("Success ClearAuthentication")
      }
    }catch let error{
        reject("Failed_Clear","Failed ClearAuthentication", NSError(domain: "Failed ClearAuthentication", code: 400))
    }
  }
  
}
