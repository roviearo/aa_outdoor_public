import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/domain/repositories/equipment_shared_prefs_repository.dart';

class GetEquipmentView extends UsecaseWithoutParams<int?> {
  GetEquipmentView(this._equipmentSharedPrefsRepository);
  final EquipmentSharedPrefsRepository _equipmentSharedPrefsRepository;

  @override
  ResultFuture<int?> call() =>
      _equipmentSharedPrefsRepository.getEquipmentView();
}
