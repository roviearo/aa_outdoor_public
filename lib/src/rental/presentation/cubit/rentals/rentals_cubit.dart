import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/rental.dart';
import '../../../domain/usecases.dart';

part 'rentals_state.dart';
part 'rentals_cubit.freezed.dart';

enum RentalsStatus { initial, loading, loaded, error, success }

class RentalsCubit extends Cubit<RentalsState> {
  RentalsCubit({
    required GetListRentalByStatus getListRentalByStatus,
    required ReturnRental returnRental,
  })  : _getListRentalByStatus = getListRentalByStatus,
        _returnRental = returnRental,
        super(const RentalsState.initial());

  final GetListRentalByStatus _getListRentalByStatus;
  final ReturnRental _returnRental;

  returnRental(String rentalId) async {
    emit(state.copyWith(status: RentalsStatus.loading));

    final result = await _returnRental.call(ReturnRentalParams(id: rentalId));

    result.fold(
      (failure) => emit(state.copyWith(
        status: RentalsStatus.error,
        message: failure.message,
      )),
      (_) {
        emit(state.copyWith(status: RentalsStatus.success));
      },
    );
  }

  loadUnfinishedRental() async {
    emit(state.copyWith(status: RentalsStatus.loading));

    final listRental = await _getListRentalByStatus
        .call(GetListRentalByStatusParams(status: Constants.rentalUndone));

    listRental.fold(
      (failure) => emit(state.copyWith(
        status: RentalsStatus.error,
        message: failure.message,
      )),
      (listRental) => emit(state.copyWith(
        status: RentalsStatus.loaded,
        listRental: listRental,
      )),
    );
  }

  loadFinishedRental() async {
    emit(state.copyWith(status: RentalsStatus.loading));

    final listRental = await _getListRentalByStatus
        .call(GetListRentalByStatusParams(status: Constants.rentalDone));

    listRental.fold(
      (failure) => emit(state.copyWith(
        status: RentalsStatus.error,
        message: failure.message,
      )),
      (listRental) => emit(state.copyWith(
        status: RentalsStatus.loaded,
        listRental: listRental,
      )),
    );
  }
}
