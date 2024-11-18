part of 'add_rental_cubit.dart';

@freezed
class AddRentalState with _$AddRentalState {
  const factory AddRentalState.initial({
    @Default('') String name,
    @Default('') String address,
    @Default('') String phoneNumber,
    @Default('') String nameIdCard,
    @Default('KTP') String idCardType,
    DateTime? startDate,
    DateTime? endDate,
    int? gapDay,
    @Default(0) int equipmentPrice,
    @Default(0) int packagePrice,
    @Default(0) int totalPrice,
    @Default([]) List<Equipment> selectedEquipment,
    GroupingEquipment? groupingEquipment,
    @Default([]) List<Package> selectedPackage,
    GroupingPackage? groupingPackage,
    @Default(0) int paymentNominal,
    @Default(0) int returnNominal,
    File? photoPayment,
    @Default(AddRentalStatus.initial) AddRentalStatus addRentalStatus,
    @Default('') String message,
    @Default('') String newRentalId,
    @Default(PaymentType.cash) PaymentType paymentType,
  }) = Initial;
}
