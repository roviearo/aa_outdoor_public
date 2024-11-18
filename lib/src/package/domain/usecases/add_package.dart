import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../../equipment/domain/entities/equipment.dart';
import '../repositories/package_repository.dart';

class AddPackage extends UsecaseWithParams<void, AddPackageParams> {
  AddPackage(this._packageRepository);

  final PackageRepository _packageRepository;

  @override
  ResultFuture<void> call(AddPackageParams params) =>
      _packageRepository.addPackage(
        params.name,
        params.price,
        params.groupingEquipment,
      );
}

class AddPackageParams extends Equatable {
  const AddPackageParams({
    required this.name,
    required this.price,
    required this.groupingEquipment,
  });

  final String name;
  final int price;
  final GroupingEquipment groupingEquipment;

  @override
  List<Object> get props => [name, price, groupingEquipment];
}
