import TruVideoReactTurboCoreSdk from './NativeTruVideoReactTurboCoreSdk';

export function multiply(a: number, b: number): number {
  return TruVideoReactTurboCoreSdk.multiply(a, b);
}

export function isAuthenticated(): Promise<string> {
  return TruVideoReactTurboCoreSdk.isAuthenticated();
}
