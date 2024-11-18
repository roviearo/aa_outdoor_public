import 'package:equatable/equatable.dart';

import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/domain/repositories/equipment_repository.dart';

class UpdateEquipment extends UsecaseWithParams<void, UpdateEquipmentParams> {
  UpdateEquipment(this._equipmentRepository);

  final EquipmentRepository _equipmentRepository;

  @override
  ResultFuture<void> call(UpdateEquipmentParams params) =>
      _equipmentRepository.updateEquipment(
        params.id,
        params.name,
        params.price,
        params.stockQty,
        params.categoryId,
      );
}

class UpdateEquipmentParams extends Equatable {
  const UpdateEquipmentParams({
    required this.id,
    required this.name,
    required this.price,
    required this.stockQty,
    required this.categoryId,
  });
  final String id;
  final String name;
  final String price;
  final String stockQty;
  final String categoryId;

  @override
  List<Object> get props {
    return [
      id,
      name,
      price,
      stockQty,
      categoryId,
    ];
  }
}
