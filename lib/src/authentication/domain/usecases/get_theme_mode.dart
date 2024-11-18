import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repository/authentication_repository.dart';

class GetThemeMode extends UsecaseWithoutParams<int?> {
  GetThemeMode(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<int?> call() => _repository.getThemeMode();
}
