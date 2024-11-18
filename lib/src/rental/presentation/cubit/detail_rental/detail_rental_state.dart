part of 'detail_rental_cubit.dart';

@freezed
class DetailRentalState with _$DetailRentalState {
  const factory DetailRentalState.initial({
    @Default(Rental.empty()) Rental rental,
    @Default(DetailRentalStatus.initial) DetailRentalStatus status,
    @Default('') String message,
  }) = Initial;
}
