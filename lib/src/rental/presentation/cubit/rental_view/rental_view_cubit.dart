import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/usecases.dart';

part 'rental_view_state.dart';
part 'rental_view_cubit.freezed.dart';

enum RentalSharedPrefsStatus { loading, loaded }

class RentalViewCubit extends Cubit<RentalViewState> {
  RentalViewCubit({
    required GetRentalView getRentalView,
    required SaveRentalView saveRentalView,
  })  : _getRentalView = getRentalView,
        _saveRentalView = saveRentalView,
        super(const RentalViewState.initial());

  final GetRentalView _getRentalView;
  final SaveRentalView _saveRentalView;

  loadRentalView() async {
    final result = await _getRentalView.call();

    result.fold(
      (failure) => emit(state.copyWith(message: failure.message)),
      (rentalView) => emit(state.copyWith(
        rentalView: rentalView,
        status: RentalSharedPrefsStatus.loaded,
      )),
    );
  }

  writeRentalView(int view) async {
    final result = await _saveRentalView.call(SaveRentalViewParams(view: view));

    result.fold(
      (failure) => emit(state.copyWith(message: failure.message)),
      (_) => loadRentalView(),
    );
  }
}
