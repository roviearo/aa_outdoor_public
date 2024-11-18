import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../../equipment/domain/entities/equipment.dart';
import '../repositories/package_repository.dart';

class UpdatePackage extends UsecaseWithParams<void, UpdatePackageParams> {
  UpdatePackage(this._packageRepository);

  final PackageRepository _packageRepository;

  @override
  ResultFuture<void> call(UpdatePackageParams params) =>
      _packageRepository.updatePackage(
        params.id,
        params.name,
        params.price,
        params.oldGroupingEquipment,
        params.groupingEquipment,
      );
}

class UpdatePackageParams extends Equatable {
  const UpdatePackageParams({
    required this.id,
    required this.name,
    required this.price,
    required this.oldGroupingEquipment,
    required this.groupingEquipment,
  });

  final String id;
  final String name;
  final int price;
  final GroupingEquipment oldGroupingEquipment;
  final GroupingEquipment groupingEquipment;

  @override
  List<Object> get props =>
      [id, name, price, oldGroupingEquipment, groupingEquipment];
}
