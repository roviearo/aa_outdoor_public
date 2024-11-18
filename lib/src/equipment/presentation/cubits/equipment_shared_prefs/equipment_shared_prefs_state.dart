part of 'equipment_shared_prefs_cubit.dart';

@freezed
class EquipmentSharedPrefsState with _$EquipmentSharedPrefsState {
  const factory EquipmentSharedPrefsState.initial({
    @Default(-1) int? equipmentCategory,
    @Default(0) int? equipmentView,
    @Default('') String message,
    @Default(EquipmentSharedPrefsStatus.loading)
    EquipmentSharedPrefsStatus status,
  }) = Intial;
}
