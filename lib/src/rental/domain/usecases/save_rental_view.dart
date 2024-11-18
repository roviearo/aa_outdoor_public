import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/rental_shared_prefs_repository.dart';

class SaveRentalView extends UsecaseWithParams<void, SaveRentalViewParams> {
  SaveRentalView(this._prefsRepository);
  final RentalSharedPrefsRepository _prefsRepository;

  @override
  ResultFuture<void> call(SaveRentalViewParams params) =>
      _prefsRepository.saveRentalView(params.view);
}

class SaveRentalViewParams extends Equatable {
  const SaveRentalViewParams({required this.view});
  final int view;

  @override
  List<Object> get props => [view];
}
