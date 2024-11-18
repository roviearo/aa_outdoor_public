import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '/core/errors/exception.dart';
import '/core/errors/failure.dart';
import '/core/utils/typedef.dart';
import '/src/authentication/data/datasources/authentication_remote_data_source.dart';
import '/src/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<supabase.User?> signIn(
      {required String email, required String password}) async {
    try {
      final result =
          await _remoteDataSource.signIn(email: email, password: password);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid signOut() async {
    try {
      await _remoteDataSource.signOut();

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  Stream<supabase.AuthState> authState() {
    return _remoteDataSource.authState();
  }

  @override
  ResultFuture<int?> getThemeMode() async {
    try {
      final result = await _remoteDataSource.getThemeMode();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid saveThemeMode(int value) async {
    try {
      await _remoteDataSource.saveThemeMode(value);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
