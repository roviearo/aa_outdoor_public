import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../../printer/domain/usecases/get_bluetooth_mac_address.dart';
import '/src/authentication/domain/usecases.dart';

part 'authentication_bloc.freezed.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required SignIn signIn,
    required SignOut signOut,
    required AuthState authState,
    required GetBluetoothMacAddress getBluetoothMacAddress,
  })  : _signIn = signIn,
        _signOut = signOut,
        _getBluetoothMacAddress = getBluetoothMacAddress,
        super(const Initial()) {
    on<AuthUserChanged>(_onAuthUserChanged);
    on<SignInEvent>(_onSignInEvent);
    on<SignOutEvent>(_onSignOutEvent);

    authState.call().listen((data) {
      add(AuthUserChanged(data.event, data.session));
    });
  }
  supabase.AuthChangeEvent? authChangeEvent;
  supabase.Session? session;

  final SignIn _signIn;
  final SignOut _signOut;
  final GetBluetoothMacAddress _getBluetoothMacAddress;

  _onAuthUserChanged(
      AuthUserChanged event, Emitter<AuthenticationState> emit) async {
    String? bluetoothMacAddress;
    final result = await _getBluetoothMacAddress.call();
    result.fold(
      (l) => bluetoothMacAddress = '',
      (macAddress) => bluetoothMacAddress = macAddress,
    );
    event.session?.accessToken != null
        ? emit(Authenticated(bluetoothMacAddress))
        : emit(const Unauthenticated());
  }

  _onSignInEvent(SignInEvent event, Emitter<AuthenticationState> emit) async {
    emit(const SigningIn());

    final result = await _signIn(
        SignInParams(email: event.email, password: event.password));

    result.fold(
      (failure) {
        emit(AuthenticationError(failure.message, failure.errorCode));
      },
      (user) => emit(SignedIn(user)),
    );
  }

  _onSignOutEvent(SignOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(const SigningOut());

    final result = await _signOut();

    result.fold(
      (failure) => failure.errorMessage,
      (r) => emit(const SignedOut()),
    );
  }
}
