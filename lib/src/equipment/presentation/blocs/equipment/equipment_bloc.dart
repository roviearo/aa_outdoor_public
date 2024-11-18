import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/src/equipment/domain/entities.dart';
import '/src/equipment/domain/usecases.dart';

part 'equipment_bloc.freezed.dart';
part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  EquipmentBloc({
    required AddEquipment addEquipment,
    required DeleteEquipment deleteEquipment,
    required GetListEquipmentByCategory getListEquipmentByCategory,
    required GetListEquipment getListEquipment,
    required UpdateEquipment updateEquipment,
  })  : _addEquipment = addEquipment,
        _deleteEquipment = deleteEquipment,
        _getListEquipmentByCategory = getListEquipmentByCategory,
        _getListEquipment = getListEquipment,
        _updateEquipment = updateEquipment,
        super(const Initial()) {
    on<LoadListEquipment>(_onLoadListEquipment);
    on<AddNewEquipment>(_onAddNewEquipment);
    on<UpdateEquipmentEvent>(_onUpdateEquipmentEvent);
    on<LoadListEquipmentByCategory>(_onLoadListEquipmentByCategory);
    on<DeleteEquipmentEvent>(_onDeleteEquipmentEvent);
  }

  final AddEquipment _addEquipment;
  final DeleteEquipment _deleteEquipment;
  final GetListEquipmentByCategory _getListEquipmentByCategory;
  final GetListEquipment _getListEquipment;
  final UpdateEquipment _updateEquipment;

  _onLoadListEquipment(
    LoadListEquipment event,
    Emitter<EquipmentState> emit,
  ) async {
    emit(const EquipmentLoading());

    if (event.categoryId != null) {
      final result = await _getListEquipmentByCategory
          .call(GetListEquipmentByCategoryParams(event.categoryId!));
      result.fold(
        (failure) => emit(EquipmentError(message: failure.message)),
        (listEquipment) =>
            emit(ListEquipmentLoaded(listEquipment: listEquipment)),
      );
    } else {
      final result = await _getListEquipment.call();

      result.fold(
        (failure) => emit(EquipmentError(message: failure.message)),
        (listEquipment) =>
            emit(ListEquipmentLoaded(listEquipment: listEquipment)),
      );
    }
  }

  _onAddNewEquipment(
    AddNewEquipment event,
    Emitter<EquipmentState> emit,
  ) async {
    emit(const EquipmentLoading());

    final result = await _addEquipment.call(AddEquipmentParams(
      name: event.name,
      price: event.price,
      stockQty: event.stockQty,
      categoryId: event.categoryId,
    ));

    result.fold(
      (failure) => emit(EquipmentError(message: failure.message)),
      (_) => emit(const AddEquipmentSucceeded()),
    );
  }

  _onUpdateEquipmentEvent(
    UpdateEquipmentEvent event,
    Emitter<EquipmentState> emit,
  ) async {
    emit(const EquipmentLoading());

    final result = await _updateEquipment.call(UpdateEquipmentParams(
      id: event.id,
      name: event.name,
      price: event.price,
      stockQty: event.stockQty,
      categoryId: event.categoryId,
    ));

    result.fold(
      (failure) => emit(EquipmentError(message: failure.message)),
      (_) => emit(const UpdateEquipmentSucceeded()),
    );
  }

  _onLoadListEquipmentByCategory(
    LoadListEquipmentByCategory event,
    Emitter<EquipmentState> emit,
  ) async {
    emit(const EquipmentLoading());

    final result = await _getListEquipmentByCategory
        .call(GetListEquipmentByCategoryParams(event.categoryId));

    result.fold(
      (failure) => emit(EquipmentError(message: failure.message)),
      (listEquipment) =>
          emit(ListEquipmentsByCategoryLoaded(listEquipment: listEquipment)),
    );
  }

  _onDeleteEquipmentEvent(
    DeleteEquipmentEvent event,
    Emitter<EquipmentState> emit,
  ) async {
    emit(const EquipmentLoading());

    final result = await _deleteEquipment.call(DeleteEquipmentParams(event.id));

    result.fold(
      (failure) => emit(DeleteEquipmentError(message: failure.message)),
      (_) => emit(const DeleteEquipmentSucceeded()),
    );
  }
}
