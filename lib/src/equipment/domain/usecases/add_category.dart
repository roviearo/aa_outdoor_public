import 'package:equatable/equatable.dart';

import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/domain/repositories/equipment_repository.dart';

class AddCategory extends UsecaseWithParams<void, AddCategoryParams> {
  AddCategory(this._equipmentRepository);
  final EquipmentRepository _equipmentRepository;

  @override
  ResultFuture<void> call(AddCategoryParams params) =>
      _equipmentRepository.addCategory(params.name);
}

class AddCategoryParams extends Equatable {
  const AddCategoryParams({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}
