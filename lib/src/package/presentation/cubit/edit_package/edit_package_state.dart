part of 'edit_package_cubit.dart';

@freezed
class EditPackageState with _$EditPackageState {
  const factory EditPackageState.initial({
    @Default(EditPackageStatus.initial) EditPackageStatus status,
    @Default('') String id,
    @Default('') String name,
    @Default(0) int price,
    @Default(0) int grossPrice,
    @Default([]) List<Equipment> selectedEquipment,
    @Default([]) List<Equipment> listEquipment,
    @Default(GroupingEquipment(listEquipment: []))
    GroupingEquipment oldGroupingEquipment,
    @Default(GroupingEquipment(listEquipment: []))
    GroupingEquipment groupingEquipment,
    @Default('') String message,
  }) = Initial;
}
