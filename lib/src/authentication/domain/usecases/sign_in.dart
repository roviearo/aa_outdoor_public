import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/authentication/domain/repository/authentication_repository.dart';

class SignIn extends UsecaseWithParams<supabase.User?, SignInParams> {
  SignIn(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<supabase.User?> call(SignInParams params) async =>
      _repository.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams.empty()
      : this(
          email: '_empty.string',
          password: '_empty.string',
        );
  const SignInParams({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
