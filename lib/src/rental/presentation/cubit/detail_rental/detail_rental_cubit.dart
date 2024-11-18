import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/rental.dart';
import '../../../domain/usecases.dart';

part 'detail_rental_state.dart';
part 'detail_rental_cubit.freezed.dart';

enum DetailRentalStatus { initial, loading, loaded, error }

class DetailRentalCubit extends Cubit<DetailRentalState> {
  DetailRentalCubit({
    required GetDetailRental getDetailRental,
  })  : _getDetailRental = getDetailRental,
        super(const DetailRentalState.initial());

  final GetDetailRental _getDetailRental;

  getDetailRental(String rentalId) async {
    final result =
        await _getDetailRental.call(GetDetailRentalParams(id: rentalId));

    result.fold(
      (failure) => emit(state.copyWith(
          status: DetailRentalStatus.error, message: failure.message)),
      (rental) => loadDetailRental(rental),
    );
  }

  loadDetailRental(Rental rental) {
    emit(state.copyWith(status: DetailRentalStatus.loading));

    emit(state.copyWith(rental: rental, status: DetailRentalStatus.loaded));
  }
}
