import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/rental_shared_prefs_repository.dart';

class GetRentalView extends UsecaseWithoutParams<int?> {
  GetRentalView(this._prefsRepository);
  final RentalSharedPrefsRepository _prefsRepository;

  @override
  ResultFuture<int?> call() => _prefsRepository.getRentalView();
}
