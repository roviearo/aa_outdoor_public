import '/core/utils/typedef.dart';

abstract class EquipmentSharedPrefsRepository {
  ResultVoid saveEquipmentCategory(int value);
  ResultFuture<int?> getEquipmentCategory();
  ResultVoid saveEquipmentView(int value);
  ResultFuture<int?> getEquipmentView();
}
