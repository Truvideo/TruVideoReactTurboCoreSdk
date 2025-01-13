import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  multiply(a: number, b: number): number;
  isAuthenticated(): Promise<string>;
  isAuthenticationExpired(): Promise<string>;
  generatePayload(): Promise<string>;
  initAuthentication(): Promise<string>;
  authenticate(
    apiKey: string,
    payload: string,
    signature: string,
    externalId: string
  ): Promise<string>;
  clearAuthentication(): Promise<string>;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  'TruVideoReactTurboCoreSdk'
);
