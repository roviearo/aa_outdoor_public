part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = Initial;
  const factory AuthenticationState.authenticated(String? macAddress) =
      Authenticated;
  const factory AuthenticationState.unauthenticated() = Unauthenticated;
  const factory AuthenticationState.signingIn() = SigningIn;
  const factory AuthenticationState.signingOut() = SigningOut;
  const factory AuthenticationState.signedIn(supabase.User? user) = SignedIn;
  const factory AuthenticationState.signedOut() = SignedOut;
  const factory AuthenticationState.authenticationError(
      String message, String? errorCode) = AuthenticationError;
}
