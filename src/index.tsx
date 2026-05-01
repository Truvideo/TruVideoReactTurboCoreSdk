import TruVideoReactTurboCoreSdk from './NativeTruVideoReactTurboCoreSdk';

// export function multiply(a: number, b: number): number {
//   return TruVideoReactTurboCoreSdk.multiply(a, b);
// }

export async function isAuthenticated(): Promise<boolean> {
  try {
    const response = await TruVideoReactTurboCoreSdk.isAuthenticated();
    if (typeof response === 'boolean') return response;
    if (typeof response === 'string') return JSON.parse(response.toLowerCase());
    console.error('Unexpected response type for isAuthenticated:', typeof response);
    return false;
  } catch (e) {
    console.error('Failed to parse isAuthenticated response:', e);
    return false;
  }
}


export async function isAuthenticationExpired(): Promise<boolean> {
  try {
    const response = await TruVideoReactTurboCoreSdk.isAuthenticationExpired();

    if (typeof response === "boolean") {
      return response;
    }

    // Handle stringified boolean
    if (typeof response === "string") {
      return JSON.parse(response.toLowerCase());
    }

    console.error("Unexpected response type for isAuthenticationExpired:", typeof response);
    return false;
  } catch (e) {
    console.error("Failed to parse isAuthenticationExpired response:", e);
    return false;
  }
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

export function generateOtp(
  baseUrl: string,
  apiKey: string,
  secret: string,
  externalId: string
): Promise<string> {
  return TruVideoReactTurboCoreSdk.generateOtp(baseUrl, apiKey, secret, externalId);
}

export function authenticateWithOtp(otp: string): Promise<string> {
  return TruVideoReactTurboCoreSdk.authenticateWithOtp(otp);
}