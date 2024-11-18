part of 'packages_cubit.dart';

@freezed
class PackagesState with _$PackagesState {
  const factory PackagesState.initial({
    @Default([]) List<Package> listPackage,
    @Default(PackagesStatus.initial) PackagesStatus status,
    @Default('') String message,
  }) = Initial;
}
