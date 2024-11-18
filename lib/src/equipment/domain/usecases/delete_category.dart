import 'package:equatable/equatable.dart';

import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/domain/repositories/equipment_repository.dart';

class DeleteCategory extends UsecaseWithParams<void, DeleteCategoryParams> {
  DeleteCategory(this._equipmentRepository);
  final EquipmentRepository _equipmentRepository;

  @override
  ResultFuture<void> call(DeleteCategoryParams params) =>
      _equipmentRepository.deleteCategory(params.id);
}

class DeleteCategoryParams extends Equatable {
  const DeleteCategoryParams({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}
