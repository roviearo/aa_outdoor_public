import '../../../../core/utils/typedef.dart';
import '../../../equipment/domain/entities/equipment.dart';
import '../entities/package.dart';

abstract class PackageRepository {
  ResultFuture<List<Package>> getListPackage();
  ResultFuture<Package> getDetailPackage(String id);
  ResultVoid deletePackage(String id);
  ResultVoid addPackage(
    String name,
    int price,
    GroupingEquipment groupingEquipment,
  );
  ResultVoid updatePackage(
    String id,
    String name,
    int price,
    GroupingEquipment oldGroupingEquipment,
    GroupingEquipment groupingEquipment,
  );
}
