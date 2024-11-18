import '/core/utils/typedef.dart';
import '/src/equipment/domain/entities.dart';

abstract class EquipmentRepository {
  ResultFuture<List<Category>> getListCategory();
  ResultVoid addCategory(String name);
  ResultVoid deleteCategory(String id);
  ResultVoid updateCategory(String id, String name);
  ResultVoid addEquipment(
    String name,
    String price,
    String stockQty,
    String categoryId,
  );
  ResultVoid deleteEquipment(String id);
  ResultFuture<List<Equipment>> getListEquipment();
  ResultVoid updateEquipment(
    String id,
    String name,
    String price,
    String stockQty,
    String categoryId,
  );
  ResultFuture<List<Equipment>> getListEquipmentsByCategory(String categoryId);
  ResultFuture<List<Equipment>> searchEquipment(String query);
}
