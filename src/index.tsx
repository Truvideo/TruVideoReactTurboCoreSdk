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

export function authentication(
  apiKey: string,
  secretKey: string,
  extenalId: string
): Promise<string> {
  return TruVideoReactTurboCoreSdk.authentication(apiKey, secretKey, extenalId);
}

export function clearAuthentication(): Promise<string> {
  return TruVideoReactTurboCoreSdk.clearAuthentication();
}

