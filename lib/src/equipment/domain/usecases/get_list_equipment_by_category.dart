import 'package:equatable/equatable.dart';

import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/domain/entities/equipment.dart';
import '/src/equipment/domain/repositories/equipment_repository.dart';

class GetListEquipmentByCategory extends UsecaseWithParams<List<Equipment>,
    GetListEquipmentByCategoryParams> {
  GetListEquipmentByCategory(this._equipmentRepository);

  final EquipmentRepository _equipmentRepository;

  @override
  ResultFuture<List<Equipment>> call(GetListEquipmentByCategoryParams params) =>
      _equipmentRepository.getListEquipmentsByCategory(params.categoryId);
}

class GetListEquipmentByCategoryParams extends Equatable {
  const GetListEquipmentByCategoryParams(this.categoryId);

  final String categoryId;

  @override
  List<Object> get props => [categoryId];
}
