import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/equipment.dart';
import '../repositories/equipment_repository.dart';

class SearchEquipment
    extends UsecaseWithParams<List<Equipment>, SearchEquipmentParams> {
  SearchEquipment(this._equipmentRepository);

  final EquipmentRepository _equipmentRepository;

  @override
  ResultFuture<List<Equipment>> call(SearchEquipmentParams params) =>
      _equipmentRepository.searchEquipment(params.query);
}

class SearchEquipmentParams extends Equatable {
  const SearchEquipmentParams({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}
