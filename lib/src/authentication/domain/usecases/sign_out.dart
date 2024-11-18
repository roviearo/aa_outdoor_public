import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/authentication/domain/repository/authentication_repository.dart';

class SignOut extends UsecaseWithoutParams<void> {
  SignOut(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture call() async => _repository.signOut();
}
