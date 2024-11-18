part of 'add_package_cubit.dart';

@freezed
class AddPackageState with _$AddPackageState {
  const factory AddPackageState.initial({
    @Default(AddPackageStatus.initial) AddPackageStatus status,
    @Default('') String name,
    @Default(0) int price,
    @Default(0) int grossPrice,
    @Default([]) List<Equipment> selectedEquipment,
    @Default(GroupingEquipment(listEquipment: []))
    GroupingEquipment groupingEquipment,
    @Default('') String message,
  }) = Initial;
}
