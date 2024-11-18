import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../equipment/domain/entities.dart';
import '../../../../package/domain/entities/package.dart';
import '../../../domain/usecases/add_rental.dart';

part 'add_rental_state.dart';
part 'add_rental_cubit.freezed.dart';

enum AddRentalStatus {
  initial,
  submitting,
  success,
  error,
  printFailed,
}

enum PaymentType {
  cash,
  transfer,
  qris,
}

class AddRentalCubit extends Cubit<AddRentalState> {
  AddRentalCubit({
    required AddRental addRental,
  })  : _addRental = addRental,
        super(const AddRentalState.initial());

  final AddRental _addRental;

  nameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  addressChanged(String value) {
    emit(state.copyWith(address: value));
  }

  phoneNumberChanged(String value) {
    emit(state.copyWith(phoneNumber: value));
  }

  nameIdCardChanged(String value) {
    emit(state.copyWith(nameIdCard: value));
  }

  idCardTypeChanged(String value) {
    emit(state.copyWith(idCardType: value));
  }

  startDateChanged(DateTime value) {
    emit(state.copyWith(startDate: value));
  }

  endDateChanged(DateTime value) {
    emit(state.copyWith(endDate: value));
  }

  gapDayChanged(int value) {
    emit(state.copyWith(gapDay: value));
    final totalPrice = state.gapDay! * state.equipmentPrice +
        state.gapDay! * state.packagePrice;
    emit(state.copyWith(totalPrice: totalPrice));
  }

  equipmentPriceChanged(int value) {
    emit(state.copyWith(equipmentPrice: value));
    final totalPrice = state.gapDay! * state.equipmentPrice;
    emit(state.copyWith(totalPrice: totalPrice + state.packagePrice));
  }

  packagePriceChanged(int value) {
    emit(state.copyWith(packagePrice: value));
    final totalPrice = state.gapDay! * state.packagePrice;
    emit(state.copyWith(totalPrice: totalPrice + state.equipmentPrice));
  }

  paymentNominalChanged(int value) {
    emit(state.copyWith(paymentNominal: value));
  }

  paymentTypeChanged(PaymentType value) {
    emit(state.copyWith(paymentType: value));
  }

  photoPaymentChanged(File value) {
    emit(state.copyWith(photoPayment: value));
  }

  returnNominalChanged(int value) {
    emit(state.copyWith(returnNominal: value));
  }

  calculatePayment() {
    int calculate = state.paymentNominal - state.totalPrice;
    returnNominalChanged(calculate);
  }

  totalPriceChanged(int value) {
    emit(state.copyWith(totalPrice: value));
  }

  selectedEquipmentChanged(List<Equipment> value) {
    emit(state.copyWith(selectedEquipment: value));
    groupingEquipmentChanged(
        GroupingEquipment(listEquipment: List.from(state.selectedEquipment)));
    final totalPrice = value.fold(0, (sum, item) => sum + item.price);
    emit(state.copyWith(equipmentPrice: totalPrice));
  }

  addPackage(Package value) {
    List<Package> selectedPackage = [];
    selectedPackage.addAll(state.selectedPackage);
    selectedPackage.add(value);
    selectedPackageChanged(selectedPackage);
  }

  addEquipment(Equipment value) {
    List<Equipment> selectedEquipment = [];
    selectedEquipment.addAll(state.selectedEquipment);
    selectedEquipment.add(value);
    selectedEquipmentChanged(selectedEquipment);
  }

  removeAllSelectedPackage(Package value) {
    List<Package> selectedPackage = [];
    selectedPackage.addAll(state.selectedPackage);
    selectedPackage.removeWhere((package) => package == value);
    selectedPackageChanged(selectedPackage);
  }

  removeAllSelectedEquipment(Equipment value) {
    List<Equipment> selectedEquipment = [];
    selectedEquipment.addAll(state.selectedEquipment);
    selectedEquipment.removeWhere((equipment) => equipment == value);
    selectedEquipmentChanged(selectedEquipment);
  }

  selectedPackageChanged(List<Package> value) {
    emit(state.copyWith(selectedPackage: value));
    groupingPackageChanged(
        GroupingPackage(listPackage: List.from(state.selectedPackage)));
    final totalPrice = value.fold(0, (sum, item) => sum + item.totalPrice);
    emit(state.copyWith(packagePrice: totalPrice));
  }

  groupingEquipmentChanged(GroupingEquipment value) {
    emit(state.copyWith(groupingEquipment: value));
  }

  groupingPackageChanged(GroupingPackage value) {
    emit(state.copyWith(groupingPackage: value));
  }

  totalPrice() {
    emit(state.copyWith(
        totalPrice: state.equipmentPrice * state.gapDay! +
            state.packagePrice * state.gapDay!));
  }

  clearAddRental() {
    emit(const AddRentalState.initial());
  }

  addRental() async {
    emit(state.copyWith(addRentalStatus: AddRentalStatus.submitting));

    calculatePayment();

    final result = await _addRental.call(
      AddRentalParams(
        name: state.name,
        address: state.address,
        phoneNumber: state.phoneNumber,
        nameIdCard: state.nameIdCard,
        idCardType: state.idCardType,
        startDate: state.startDate ?? DateTime.now(),
        endDate: state.endDate ?? DateTime.now().add(const Duration(days: 1)),
        groupingEquipment: state.groupingEquipment ?? const GroupingEquipment(),
        groupingPackage: state.groupingPackage ?? const GroupingPackage(),
        paymentNominal: state.paymentNominal,
        paymentType: state.paymentType == PaymentType.cash
            ? 'CASH'
            : state.paymentType == PaymentType.transfer
                ? 'TRANSFER'
                : 'QRIS',
        returnNominal: state.returnNominal,
        totalPrice: state.totalPrice,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
          addRentalStatus: AddRentalStatus.error, message: failure.message)),
      (rentalId) => emit(state.copyWith(
          addRentalStatus: AddRentalStatus.success, newRentalId: rentalId)),
    );
  }
}
