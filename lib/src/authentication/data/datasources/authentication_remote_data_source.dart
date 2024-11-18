import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../../../core/utils/constants.dart';
import '/core/errors/exception.dart';

abstract class AuthenticationRemoteDataSource {
  Stream<supabase.AuthState> authState();
  Future<supabase.User?> signIn(
      {required String email, required String password});
  Future<void> signOut();
  Future<void> saveThemeMode(int value);
  Future<int?> getThemeMode();
  Future<int?> checkThemeMode();
}

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  AuthRemoteDataSrcImpl(this._auth, this._prefs);

  final supabase.GoTrueClient _auth;
  final SharedPreferences _prefs;

  @override
  Future<supabase.User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.signInWithPassword(
        email: email,
        password: password,
      );

      return response.user;
    } on supabase.AuthException catch (e) {
      throw APIException(
          message: e.message,
          statusCode: int.parse(e.statusCode!),
          errorCode: e.code);
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Stream<supabase.AuthState> authState() {
    return _auth.onAuthStateChange;
  }

  @override
  Future<int?> getThemeMode() async {
    return _prefs.getInt(Constants.themeMode);
  }

  @override
  Future<void> saveThemeMode(int value) async {
    await _prefs.setInt(Constants.themeMode, value);
  }

  @override
  Future<int?> checkThemeMode() async {
    return _prefs.getInt(Constants.themeMode);
  }
}
