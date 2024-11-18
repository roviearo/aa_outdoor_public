import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '/core/utils/typedef.dart';

abstract class AuthenticationRepository {
  Stream<supabase.AuthState> authState();
  ResultFuture<supabase.User?> signIn(
      {required String email, required String password});
  ResultVoid signOut();
  ResultVoid saveThemeMode(int value);
  ResultFuture<int?> getThemeMode();
}
