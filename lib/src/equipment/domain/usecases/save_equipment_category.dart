import 'package:equatable/equatable.dart';

import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/domain/repositories/equipment_shared_prefs_repository.dart';

class SaveEquipmentCategory
    extends UsecaseWithParams<void, SaveEquipmentCatgoryParams> {
  SaveEquipmentCategory(this._equipmentSharedPrefsRepository);
  final EquipmentSharedPrefsRepository _equipmentSharedPrefsRepository;

  @override
  ResultFuture<void> call(SaveEquipmentCatgoryParams params) =>
      _equipmentSharedPrefsRepository.saveEquipmentCategory(params.category);
}

class SaveEquipmentCatgoryParams extends Equatable {
  const SaveEquipmentCatgoryParams({required this.category});
  final int category;

  @override
  List<Object> get props => [category];
}
