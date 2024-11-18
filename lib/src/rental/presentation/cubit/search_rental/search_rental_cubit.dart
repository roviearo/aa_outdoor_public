import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/rental.dart';
import '../../../domain/usecases/search_rental.dart';

part 'search_rental_state.dart';
part 'search_rental_cubit.freezed.dart';

enum SearchRentalStatus { initial, found, notFound, loading, error }

class SearchRentalCubit extends Cubit<SearchRentalState> {
  SearchRentalCubit({
    required SearchRental searchRental,
  })  : _searchRental = searchRental,
        super(const SearchRentalState.initial());

  final SearchRental _searchRental;

  void clearSearch() {
    emit(const SearchRentalState.initial());
  }

  void searchRental(String query) async {
    emit(state.copyWith(status: SearchRentalStatus.initial));

    final result = await _searchRental.call(SearchRentalParams(query: query));

    result.fold(
      (failure) => emit(state.copyWith(message: failure.message)),
      (listRental) => emit(state.copyWith(
          searchResult: listRental, status: SearchRentalStatus.found)),
    );
  }
}
