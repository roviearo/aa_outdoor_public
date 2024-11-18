import 'package:equatable/equatable.dart';

import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/domain/repositories/equipment_shared_prefs_repository.dart';

class SaveEquipmentView
    extends UsecaseWithParams<void, SaveEquipmentViewParams> {
  SaveEquipmentView(this._equipmentSharedPrefsRepository);
  final EquipmentSharedPrefsRepository _equipmentSharedPrefsRepository;

  @override
  ResultFuture<void> call(SaveEquipmentViewParams params) =>
      _equipmentSharedPrefsRepository.saveEquipmentView(params.view);
}

class SaveEquipmentViewParams extends Equatable {
  const SaveEquipmentViewParams({required this.view});
  final int view;

  @override
  List<Object> get props => [view];
}
