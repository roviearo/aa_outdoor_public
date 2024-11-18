part of 'search_equipment_cubit.dart';

@freezed
class SearchEquipmentState with _$SearchEquipmentState {
  const factory SearchEquipmentState.initial({
    @Default([]) List<Equipment> searchResult,
    @Default(SearchEquipmentStatus.initial) SearchEquipmentStatus status,
    @Default('') String message,
  }) = Initial;
}
