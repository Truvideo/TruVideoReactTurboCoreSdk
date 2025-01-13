import TruVideoReactTurboCoreSdk from './NativeTruVideoReactTurboCoreSdk';

export function multiply(a: number, b: number): number {
  return TruVideoReactTurboCoreSdk.multiply(a, b);
}

export function isAuthenticated(): Promise<string> {
  return TruVideoReactTurboCoreSdk.isAuthenticated();
}

export function isAuthenticationExpired(): Promise<string> {
  return TruVideoReactTurboCoreSdk.isAuthenticationExpired();
}

export function generatePayload(): Promise<string> {
  return TruVideoReactTurboCoreSdk.generatePayload();
}

export function initAuthentication(): Promise<string> {
  return TruVideoReactTurboCoreSdk.initAuthentication();
}

export function authenticate(
  apiKey: string,
  payload: string,
  signature: string,
  externalId: string
): Promise<string> {
  return TruVideoReactTurboCoreSdk.authenticate(
    apiKey,
    payload,
    signature,
    externalId
  );
}

export function clearAuthentication(): Promise<string> {
  return TruVideoReactTurboCoreSdk.clearAuthentication();
}
