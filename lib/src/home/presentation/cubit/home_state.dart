part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({
    @Default([]) List<Rental> listRental,
    @Default(HomeStatus.initial) HomeStatus status,
    @Default('') String message,
  }) = Initial;
}
