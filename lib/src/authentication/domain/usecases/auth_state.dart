import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '/core/usecase/usecase.dart';
import '/src/authentication/domain/repository/authentication_repository.dart';

class AuthState extends UsecaseStream<supabase.AuthState> {
  AuthState(this._repository);

  final AuthenticationRepository _repository;

  @override
  Stream<supabase.AuthState> call() => _repository.authState();
}
