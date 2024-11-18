part of 'equipment_bloc.dart';

@freezed
class EquipmentEvent with _$EquipmentEvent {
  const factory EquipmentEvent.loadListEquipment({String? categoryId}) =
      LoadListEquipment;
  const factory EquipmentEvent.loadListEquipmentByCategory(
      {required String categoryId}) = LoadListEquipmentByCategory;
  const factory EquipmentEvent.addNewEquipment({
    required String name,
    required String price,
    required String stockQty,
    required String categoryId,
  }) = AddNewEquipment;
  const factory EquipmentEvent.updateEquipmentEvent({
    required String id,
    required String name,
    required String price,
    required String stockQty,
    required String categoryId,
  }) = UpdateEquipmentEvent;
  const factory EquipmentEvent.deleteEquipmentEvent({required String id}) =
      DeleteEquipmentEvent;
}
