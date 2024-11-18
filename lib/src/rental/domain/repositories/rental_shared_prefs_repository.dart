import '../../../../core/utils/typedef.dart';

abstract class RentalSharedPrefsRepository {
  ResultVoid saveRentalView(int value);
  ResultFuture<int?> getRentalView();
}
