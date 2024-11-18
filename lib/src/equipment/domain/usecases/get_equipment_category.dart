import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/domain/repositories/equipment_shared_prefs_repository.dart';

class GetEquipmentCategory extends UsecaseWithoutParams<int?> {
  GetEquipmentCategory(this._equipmentSharedPrefsRepository);
  final EquipmentSharedPrefsRepository _equipmentSharedPrefsRepository;

  @override
  ResultFuture<int?> call() =>
      _equipmentSharedPrefsRepository.getEquipmentCategory();
}
