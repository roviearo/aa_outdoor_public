part of 'rental_view_cubit.dart';

@freezed
class RentalViewState with _$RentalViewState {
  const factory RentalViewState.initial({
    @Default(0) int? rentalView,
    @Default('') String message,
    @Default(RentalSharedPrefsStatus.loading) RentalSharedPrefsStatus status,
  }) = Initial;
}
