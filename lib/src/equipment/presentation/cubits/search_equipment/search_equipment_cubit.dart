import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/equipment.dart';
import '../../../domain/usecases/search_equipment.dart';

part 'search_equipment_state.dart';
part 'search_equipment_cubit.freezed.dart';

enum SearchEquipmentStatus { initial, found, notFound, loading, error }

class SearchEquipmentCubit extends Cubit<SearchEquipmentState> {
  SearchEquipmentCubit({
    required SearchEquipment searchEquipment,
  })  : _searchEquipment = searchEquipment,
        super(const SearchEquipmentState.initial());

  final SearchEquipment _searchEquipment;

  void clearSearch() {
    emit(const SearchEquipmentState.initial());
  }

  void searchEquipment(String query) async {
    emit(state.copyWith(status: SearchEquipmentStatus.initial));

    final result =
        await _searchEquipment.call(SearchEquipmentParams(query: query));

    result.fold(
      (failure) => emit(state.copyWith(message: failure.message)),
      (listEquipment) => emit(state.copyWith(
          searchResult: listEquipment, status: SearchEquipmentStatus.found)),
    );
  }
}
