import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../equipment/domain/entities/equipment.dart';
import '../../../../equipment/domain/usecases/get_list_equipment.dart';
import '../../../domain/usecases/update_package.dart';

part 'edit_package_state.dart';
part 'edit_package_cubit.freezed.dart';

enum EditPackageStatus { initial, submitting, success, error }

class EditPackageCubit extends Cubit<EditPackageState> {
  EditPackageCubit({
    required UpdatePackage updatePackage,
    required GetListEquipment getListEquipment,
  })  : _updatePackage = updatePackage,
        _getListEquipment = getListEquipment,
        super(const EditPackageState.initial());

  final UpdatePackage _updatePackage;
  final GetListEquipment _getListEquipment;

  loadListEquipment() async {
    final result = await _getListEquipment.call();
    result.fold(
      (failure) => emit(state.copyWith(
          status: EditPackageStatus.error, message: failure.message)),
      (listEquipment) => emit(state.copyWith(listEquipment: listEquipment)),
    );
  }

  idChanged(String value) {
    emit(state.copyWith(id: value));
  }

  nameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  priceChanged(int value) {
    emit(state.copyWith(price: value));
  }

  initialGroupingEquipment(List<Equipment> value) {
    List<Equipment> selectedEquipment = [];
    for (var equipment in value) {
      for (var i = 0; i < equipment.qtyRental!; i++) {
        selectedEquipment.add(state.listEquipment
            .where((element) => element.id == equipment.id)
            .first);
      }
    }

    emit(state.copyWith(selectedEquipment: selectedEquipment));

    groupingEquipmentChanged(
        GroupingEquipment(listEquipment: List.from(selectedEquipment)));

    final grossPrice =
        selectedEquipment.fold(0, (sum, item) => sum + item.price);
    emit(state.copyWith(grossPrice: grossPrice));
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

  readEquipmentQty(List<Equipment> value) {
    List<Equipment> listEquipment = [];
    listEquipment.addAll(state.selectedEquipment);

    selectedEquipmentChanged(listEquipment);
  }

  addEquipment(Equipment value) {
    List<Equipment> listEquipment = [];
    listEquipment.addAll(state.selectedEquipment);
    listEquipment.add(value);
    selectedEquipmentChanged(listEquipment);
  }

  removeEquipment(Equipment value) {
    List<Equipment> selectedEquipment = [];
    selectedEquipment.addAll(state.selectedEquipment);
    selectedEquipment.removeWhere((element) => element == value);
    selectedEquipmentChanged(selectedEquipment);
  }

  clearEditPackage() {
    emit(state.copyWith(
      name: '',
      price: 0,
      grossPrice: 0,
      groupingEquipment: const GroupingEquipment(listEquipment: []),
      selectedEquipment: [],
      status: EditPackageStatus.initial,
    ));
  }

  updatePackage() async {
    emit(state.copyWith(status: EditPackageStatus.submitting));

    final result = await _updatePackage.call(UpdatePackageParams(
      id: state.id,
      name: state.name,
      price: state.price,
      oldGroupingEquipment: state.oldGroupingEquipment,
      groupingEquipment: state.groupingEquipment,
    ));

    result.fold(
      (failure) => emit(state.copyWith(
          status: EditPackageStatus.error, message: failure.message)),
      (_) => emit(state.copyWith(status: EditPackageStatus.success)),
    );
  }
}
