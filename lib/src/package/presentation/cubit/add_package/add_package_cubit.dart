import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../equipment/domain/entities/equipment.dart';
import '../../../domain/usecases/add_package.dart';

part 'add_package_state.dart';
part 'add_package_cubit.freezed.dart';

enum AddPackageStatus { initial, submitting, success, error }

class AddPackageCubit extends Cubit<AddPackageState> {
  AddPackageCubit({
    required AddPackage addPackage,
  })  : _addPackage = addPackage,
        super(const AddPackageState.initial());

  final AddPackage _addPackage;

  nameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  priceChanged(int value) {
    emit(state.copyWith(price: value));
  }

  selectedEquipmentChanged(List<Equipment> value) {
    emit(state.copyWith(selectedEquipment: value));

    groupingEquipmentChanged(
        GroupingEquipment(listEquipment: List.from(state.selectedEquipment)));

    final grossPrice = value.fold(0, (sum, item) => sum + item.price);
    emit(state.copyWith(grossPrice: grossPrice));
  }

  groupingEquipmentChanged(GroupingEquipment value) {
    emit(state.copyWith(groupingEquipment: value));
  }

  removeEquipment(Equipment value) {
    List<Equipment> selectedEquipment = [];
    selectedEquipment.addAll(state.selectedEquipment);
    selectedEquipment.removeWhere((element) => element == value);
    selectedEquipmentChanged(selectedEquipment);
  }

  clearAddPackage() {
    emit(const AddPackageState.initial());
  }

  addPackage() async {
    emit(state.copyWith(status: AddPackageStatus.submitting));

    final result = await _addPackage.call(AddPackageParams(
      name: state.name,
      price: state.price,
      groupingEquipment: state.groupingEquipment,
    ));

    result.fold(
      (failure) => emit(state.copyWith(
          status: AddPackageStatus.error, message: failure.message)),
      (_) => emit(state.copyWith(status: AddPackageStatus.success)),
    );
  }
}
