#import "TruVideoReactTurboCoreSdk.h"
#import "truvideo_react_turbo_core_sdk-Swift.h"
#import "TruvideoSdk/TruvideoSdk-Swift.h"
#import "TruvideoSdk/TruvideoSdk.h"

@implementation TruVideoReactTurboCoreSdk
RCT_EXPORT_MODULE()

- (NSNumber *)multiply:(double)a b:(double)b {
  NSNumber *result = @(a * b);
  return result;
}

- (void)authenticate:(NSString *)apiKey payload:(NSString *)payload signature:(NSString *)signature externalId:(NSString *)externalId resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  // authenticate
  TruVideoReactTurboCoreSDKClass *tvrtcsc = [[TruVideoReactTurboCoreSDKClass alloc] init];
  //
  [tvrtcsc authenticateWithApiKey:apiKey payload:payload signature:signature externalId:externalId completionHandler:{
    //NSLog("Success....... From iOS")
    
  }];
}
//
- (void)clearAuthentication:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  // clearAuthentication
  TruVideoReactTurboCoreSDKClass *tvrtcsc = [[TruVideoReactTurboCoreSDKClass alloc] init];
  [tvrtcsc clearAuthentication];
}

- (void)generatePayload:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  //  generatePayload
  TruVideoReactTurboCoreSDKClass *tvrtcsc = [[TruVideoReactTurboCoreSDKClass alloc] init];
  NSString *payload = [tvrtcsc generatePayload];
  resolve(payload);
}

- (void)initAuthentication:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  // initAuthentication
  TruVideoReactTurboCoreSDKClass *tvrtcsc = [[TruVideoReactTurboCoreSDKClass alloc] init];
  [tvrtcsc initAuthenticationWithCompletionHandler:{
    //TODO:- Manage
  }];
}

- (void)isAuthenticated:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  // isAuthenticated
  TruVideoReactTurboCoreSDKClass *tvrtcsc = [[TruVideoReactTurboCoreSDKClass alloc] init];
  BOOL isAuth = [tvrtcsc isAuthenticated];  // Use BOOL instead of Boolean
  
  // Wrap the BOOL in an NSNumber and resolve it
  resolve(@(isAuth));  // NSNumber representation of BOOL
}

- (void)isAuthenticationExpired:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  //  isAuthenticationExpired
  TruVideoReactTurboCoreSDKClass *tvrtcsc = [[TruVideoReactTurboCoreSDKClass alloc] init];
  BOOL isAuthExpired = [tvrtcsc isAuthenticationExpired];
  
  resolve(@(isAuthExpired));
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
(const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeTruVideoReactTurboCoreSdkSpecJSI>(params);
}

@end
