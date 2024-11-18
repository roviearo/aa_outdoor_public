import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/constants.dart';

abstract class EquipmentSharedPrefsRemoteDataSource {
  Future<void> saveEquipmentCategory(int value);
  Future<int?> getEquipmentCategory();
  Future<void> saveEquipmentView(int value);
  Future<int?> getEquipmentView();
}

class EquipmentSharedRemoteDataSrcImpl
    implements EquipmentSharedPrefsRemoteDataSource {
  EquipmentSharedRemoteDataSrcImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<int?> getEquipmentCategory() async {
    return _prefs.getInt(Constants.equipmentCategory);
  }

  @override
  Future<int?> getEquipmentView() async {
    return _prefs.getInt(Constants.equipmentView);
  }

  @override
  Future<void> saveEquipmentCategory(int value) async {
    await _prefs.setInt(Constants.equipmentCategory, value);
  }

  @override
  Future<void> saveEquipmentView(int value) async {
    await _prefs.setInt(Constants.equipmentView, value);
  }
}
