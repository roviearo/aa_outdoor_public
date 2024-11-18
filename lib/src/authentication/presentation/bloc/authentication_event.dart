part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.signInEvent(String email, String password) =
      SignInEvent;
  const factory AuthenticationEvent.signOutEvent() = SignOutEvent;
  const factory AuthenticationEvent.authUserChanged(
      supabase.AuthChangeEvent? authChangeEvent,
      supabase.Session? session) = AuthUserChanged;
}
