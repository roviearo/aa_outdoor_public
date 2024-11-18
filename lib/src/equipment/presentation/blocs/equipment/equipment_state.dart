part of 'equipment_bloc.dart';

@freezed
class EquipmentState with _$EquipmentState {
  const factory EquipmentState.initial() = Initial;
  const factory EquipmentState.error({required String message}) =
      EquipmentError;
  const factory EquipmentState.loading() = EquipmentLoading;
  const factory EquipmentState.listEquipmentLoaded(
      {required List<Equipment> listEquipment}) = ListEquipmentLoaded;
  const factory EquipmentState.listEquipmentsByCategoryLoaded(
          {required List<Equipment> listEquipment}) =
      ListEquipmentsByCategoryLoaded;
  const factory EquipmentState.addEquipmentSucceeded() = AddEquipmentSucceeded;
  const factory EquipmentState.updateEquipmentLoading() =
      UpdateEquipmentLoading;
  const factory EquipmentState.updateEquipmentSucceeded() =
      UpdateEquipmentSucceeded;
  const factory EquipmentState.deleteEquipmentError({required String message}) =
      DeleteEquipmentError;
  const factory EquipmentState.deleteEquipmentLoading() =
      DeleteEquipmentLoading;
  const factory EquipmentState.deleteEquipmentSucceeded() =
      DeleteEquipmentSucceeded;
}
