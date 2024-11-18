import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repository/authentication_repository.dart';

class SaveThemeMode extends UsecaseWithParams<void, SaveThemeModeParams> {
  SaveThemeMode(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call(SaveThemeModeParams params) =>
      _repository.saveThemeMode(params.value);
}

class SaveThemeModeParams extends Equatable {
  const SaveThemeModeParams({required this.value});

  final int value;

  @override
  List<Object> get props => [value];
}
