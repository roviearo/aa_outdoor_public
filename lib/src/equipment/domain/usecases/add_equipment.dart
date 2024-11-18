import 'package:equatable/equatable.dart';

import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/domain/repositories/equipment_repository.dart';

class AddEquipment extends UsecaseWithParams<void, AddEquipmentParams> {
  AddEquipment(this._equipmentRepository);
  final EquipmentRepository _equipmentRepository;

  @override
  ResultFuture<void> call(AddEquipmentParams params) =>
      _equipmentRepository.addEquipment(
        params.name,
        params.price,
        params.stockQty,
        params.categoryId,
      );
}

class AddEquipmentParams extends Equatable {
  const AddEquipmentParams({
    required this.name,
    required this.price,
    required this.stockQty,
    required this.categoryId,
  });

  final String name;
  final String price;
  final String stockQty;
  final String categoryId;

  @override
  List<Object> get props => [name, price, stockQty, categoryId];
}
