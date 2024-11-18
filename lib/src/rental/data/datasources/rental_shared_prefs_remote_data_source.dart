import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/constants.dart';

abstract class RentalSharedPrefsRemoteDataSource {
  Future<void> saveRentalView(int value);
  Future<int?> getRentalView();
}

class RentalSharedPrefsRemoteDataSrcImpl
    implements RentalSharedPrefsRemoteDataSource {
  RentalSharedPrefsRemoteDataSrcImpl(this._prefs);
  final SharedPreferences _prefs;

  @override
  Future<int?> getRentalView() async {
    return _prefs.getInt(Constants.rentalView);
  }

  @override
  Future<void> saveRentalView(int value) async {
    await _prefs.setInt(Constants.rentalView, value);
  }
}
