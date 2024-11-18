import 'package:equatable/equatable.dart';

import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/domain/repositories/equipment_repository.dart';

class UpdateCategory extends UsecaseWithParams<void, UpdateCategoryParams> {
  UpdateCategory(this._equipmentRepository);
  final EquipmentRepository _equipmentRepository;

  @override
  ResultFuture<void> call(UpdateCategoryParams params) =>
      _equipmentRepository.updateCategory(params.id, params.name);
}

class UpdateCategoryParams extends Equatable {
  const UpdateCategoryParams({required this.id, required this.name});
  final String id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
