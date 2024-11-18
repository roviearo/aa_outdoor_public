part of 'rentals_cubit.dart';

@freezed
class RentalsState with _$RentalsState {
  const factory RentalsState.initial({
    @Default([]) List<Rental> listRental,
    @Default(RentalsStatus.initial) RentalsStatus status,
    @Default('') String message,
  }) = Initial;
}
