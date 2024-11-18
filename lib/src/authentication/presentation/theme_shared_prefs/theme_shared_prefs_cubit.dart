import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/usecases/get_theme_mode.dart';
import '../../domain/usecases/save_theme_mode.dart';

part 'theme_shared_prefs_state.dart';
part 'theme_shared_prefs_cubit.freezed.dart';

enum ThemeSharedPrefsStatus { loading, loaded }

class ThemeSharedPrefsCubit extends Cubit<ThemeSharedPrefsState> {
  ThemeSharedPrefsCubit({
    required GetThemeMode getThemeMode,
    required SaveThemeMode saveThemeMode,
  })  : _getThemeMode = getThemeMode,
        _saveThemeMode = saveThemeMode,
        super(const ThemeSharedPrefsState.initial());

  final GetThemeMode _getThemeMode;
  final SaveThemeMode _saveThemeMode;

  loadThemeMode() async {
    final result = await _getThemeMode.call();

    result.fold(
      (failure) => emit(state.copyWith(message: failure.message)),
      (themeMode) => emit(state.copyWith(
          themeMode: themeMode, status: ThemeSharedPrefsStatus.loaded)),
    );
  }

  writeThemeMode(int value) async {
    final result = await _saveThemeMode.call(SaveThemeModeParams(value: value));

    result.fold(
      (failure) => emit(state.copyWith(message: failure.message)),
      (_) async => await loadThemeMode(),
    );
  }
}
