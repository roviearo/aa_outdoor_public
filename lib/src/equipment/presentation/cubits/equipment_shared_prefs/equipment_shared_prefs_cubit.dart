import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/src/equipment/domain/usecases.dart';

part 'equipment_shared_prefs_cubit.freezed.dart';
part 'equipment_shared_prefs_state.dart';

enum EquipmentSharedPrefsStatus { loading, loaded }

class EquipmentSharedPrefsCubit extends Cubit<EquipmentSharedPrefsState> {
  EquipmentSharedPrefsCubit({
    required GetEquipmentCategory getEquipmentCategory,
    required SaveEquipmentCategory saveEquipmentCategory,
    required GetEquipmentView getEquipmentView,
    required SaveEquipmentView saveEquipmentView,
  })  : _getEquipmentCategory = getEquipmentCategory,
        _saveEquipmentCategory = saveEquipmentCategory,
        _getEquipmentView = getEquipmentView,
        _saveEquipmentView = saveEquipmentView,
        super(const EquipmentSharedPrefsState.initial());

  final GetEquipmentCategory _getEquipmentCategory;
  final SaveEquipmentCategory _saveEquipmentCategory;
  final GetEquipmentView _getEquipmentView;
  final SaveEquipmentView _saveEquipmentView;

  loadEquipmentCategory() async {
    final result = await _getEquipmentCategory.call();
    result.fold(
      (failure) => emit(state.copyWith(message: failure.message)),
      (equipmentCategory) => emit(state.copyWith(
        equipmentCategory: equipmentCategory,
        status: EquipmentSharedPrefsStatus.loaded,
      )),
    );
  }

  writeEquipmentCategory(int category) async {
    final result = await _saveEquipmentCategory
        .call(SaveEquipmentCatgoryParams(category: category));

    result.fold(
      (failure) => emit(state.copyWith(message: failure.message)),
      (_) async => await loadEquipmentCategory(),
    );
  }

  loadEquipmentView() async {
    final result = await _getEquipmentView.call();

    result.fold(
      (failure) => emit(state.copyWith(message: failure.message)),
      (equipmentView) => emit(state.copyWith(
          equipmentView: equipmentView,
          status: EquipmentSharedPrefsStatus.loaded)),
    );
  }

  writeEquipmentView(int view) async {
    final result =
        await _saveEquipmentView.call(SaveEquipmentViewParams(view: view));
    result.fold(
      (failure) => emit(state.copyWith(message: failure.message)),
      (_) async => await loadEquipmentView(),
    );
  }
}
