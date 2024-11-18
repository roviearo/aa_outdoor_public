part of 'theme_shared_prefs_cubit.dart';

@freezed
class ThemeSharedPrefsState with _$ThemeSharedPrefsState {
  const factory ThemeSharedPrefsState.initial({
    @Default(0) int? themeMode,
    @Default('') String message,
    @Default(ThemeSharedPrefsStatus.loading) ThemeSharedPrefsStatus status,
  }) = Initial;
}
