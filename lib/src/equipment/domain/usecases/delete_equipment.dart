import 'package:equatable/equatable.dart';

import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/domain/repositories/equipment_repository.dart';

class DeleteEquipment extends UsecaseWithParams<void, DeleteEquipmentParams> {
  DeleteEquipment(this._equipmentRepository);

  final EquipmentRepository _equipmentRepository;

  @override
  ResultFuture<void> call(DeleteEquipmentParams params) =>
      _equipmentRepository.deleteEquipment(params.id);
}

class DeleteEquipmentParams extends Equatable {
  const DeleteEquipmentParams(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}
