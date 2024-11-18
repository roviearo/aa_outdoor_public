import '/core/usecase/usecase.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/domain/entities/category.dart';
import '/src/equipment/domain/repositories/equipment_repository.dart';

class GetListCategory extends UsecaseWithoutParams<List<Category>> {
  GetListCategory(this._equipmentRepository);
  final EquipmentRepository _equipmentRepository;

  @override
  ResultFuture<List<Category>> call() => _equipmentRepository.getListCategory();
}
