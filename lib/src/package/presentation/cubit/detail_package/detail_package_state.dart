part of 'detail_package_cubit.dart';

@freezed
class DetailPackageState with _$DetailPackageState {
  const factory DetailPackageState.initial({
    @Default(Package.empty()) Package package,
    @Default(DetailPackageStatus.initial) DetailPackageStatus status,
    @Default('') String message,
  }) = Initial;
}
