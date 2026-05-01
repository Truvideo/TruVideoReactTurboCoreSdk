#import "TruVideoReactTurboCoreSdk.h"
#import "truvideo_react_turbo_core_sdk-Swift.h"
//#import "TruvideoSdk/TruvideoSdk-Swift.h"
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
  [tvrtcsc authenticateWithApiKey:apiKey payload:payload signature:signature externalId:externalId resolve:resolve reject:reject];

}

- (void)clearAuthentication:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  // clearAuthentication
  TruVideoReactTurboCoreSDKClass *tvrtcsc = [[TruVideoReactTurboCoreSDKClass alloc] init];
  [tvrtcsc clearAuthenticationWithResolve:resolve reject:reject];
 
}

- (void)generatePayload:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  //  generatePayload
  TruVideoReactTurboCoreSDKClass *tvrtcsc = [[TruVideoReactTurboCoreSDKClass alloc] init];
  [tvrtcsc generatePayloadWithResolve:resolve reject:reject];
 
}

- (void)initAuthentication:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  // initAuthentication
  TruVideoReactTurboCoreSDKClass *tvrtcsc = [[TruVideoReactTurboCoreSDKClass alloc] init];
  [tvrtcsc initAuthenticationWithResolve:resolve reject:reject];

}

- (void)isAuthenticated:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  // isAuthenticated
  TruVideoReactTurboCoreSDKClass *tvrtcsc = [[TruVideoReactTurboCoreSDKClass alloc] init];
  [tvrtcsc isAuthenticatedWithResolve:resolve reject:reject];
}

- (void)isAuthenticationExpired:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  //  isAuthenticationExpired
  TruVideoReactTurboCoreSDKClass *tvrtcsc = [[TruVideoReactTurboCoreSDKClass alloc] init];
  [tvrtcsc isAuthenticationExpiredWithResolve:resolve reject:reject];
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
(const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeTruVideoReactTurboCoreSdkSpecJSI>(params);
}

- (void)authenticateWithOtp:(NSString *)otp resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    TruVideoReactTurboCoreSDKClass *tvrtcsc = [[TruVideoReactTurboCoreSDKClass alloc] init];
    [tvrtcsc authenticateWithOtpWithOtp:otp resolve:resolve reject:reject];
}

@end
