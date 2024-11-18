import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../rental/domain/entities/rental.dart';
import '../../../rental/domain/usecases/get_list_rental_by_status.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required GetListRentalByStatus getListRentalByStatus,
  })  : _getListRentalByStatus = getListRentalByStatus,
        super(const HomeState.initial());

  final GetListRentalByStatus _getListRentalByStatus;

  loadHomeCubit(String status) async {
    final listRental = await _getListRentalByStatus
        .call(GetListRentalByStatusParams(status: status));

    listRental.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.error,
        message: failure.message,
      )),
      (listRental) {
        listRental.sort((a, b) => a.endDate.compareTo(b.endDate));
        emit(state.copyWith(
          status: HomeStatus.loaded,
          listRental: listRental,
        ));
      },
    );
  }
}
