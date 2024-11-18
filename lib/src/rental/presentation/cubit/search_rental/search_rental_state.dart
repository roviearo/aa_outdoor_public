part of 'search_rental_cubit.dart';

@freezed
class SearchRentalState with _$SearchRentalState {
  const factory SearchRentalState.initial({
    @Default([]) List<Rental> searchResult,
    @Default(SearchRentalStatus.initial) SearchRentalStatus status,
    @Default('') String message,
  }) = Initial;
}
