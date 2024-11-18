import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/domain/entities/equipment.dart';
import '/src/equipment/domain/repositories/equipment_repository.dart';

class GetListEquipment extends UsecaseWithoutParams<List<Equipment>> {
  GetListEquipment(this._equipmentRepository);

  final EquipmentRepository _equipmentRepository;

  @override
  ResultFuture<List<Equipment>> call() =>
      _equipmentRepository.getListEquipment();
}
