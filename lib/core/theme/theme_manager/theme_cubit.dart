import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quran_app/core/cache_keys.dart';
import 'package:flutter_quran_app/core/di/di.dart';
import 'package:flutter_quran_app/core/services/cache_service.dart';
import 'package:flutter_quran_app/core/theme/app_themes.dart';

import '../custom_theme_model.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeInitial(theme: _themes['blue']!, mode: ThemeMode.light)) {
    init();
  }
  final _cache = getIt<CacheService>();

  Future<void> init() async {
    // Load saved theme
    final savedThemeKey = await _cache.getString(CacheKeys.selectedTheme);
    final themeMode = await _cache.getString(CacheKeys.themeMode);

    CustomTheme selectedTheme = _themes[savedThemeKey ?? 'blue']!;
    ThemeMode mode = ThemeMode.light;

    if (savedThemeKey != null && _themes.containsKey(savedThemeKey)) {
      selectedTheme = _themes[savedThemeKey]!;
    }

    if (themeMode == CacheKeys.darkTheme) {
      mode = ThemeMode.dark;
    }

    emit(ThemeChanged(theme: selectedTheme, mode: mode));
  }

  void switchTheme() {
    if (state.mode == ThemeMode.light) {
      _cache.setString(CacheKeys.themeMode, CacheKeys.darkTheme);
      emit(ThemeChanged(theme: state.theme, mode: ThemeMode.dark));
    } else {
      _cache.setString(CacheKeys.themeMode, CacheKeys.lightTheme);
      emit(ThemeChanged(theme: state.theme, mode: ThemeMode.light));
    }
  }

  void selectTheme(String themeKey) async {
    if (_themes.containsKey(themeKey)) {
      final selectedTheme = _themes[themeKey]!;
      await _cache.setString(CacheKeys.selectedTheme, themeKey);
      emit(ThemeChanged(theme: selectedTheme, mode: state.mode));
    }
  }

  Future<String?> getCurrentThemeKey() {
    return _cache.getString(CacheKeys.selectedTheme);
  }
}

final Map<String, CustomTheme> _themes = {
  'blue': CustomTheme(
    light: AppThemes.lightBlue,
    dark: AppThemes.darkBlue,
  ),
  'red': CustomTheme(
    light: AppThemes.red,
    dark: AppThemes.darkRed,
  ),
  'cyan': CustomTheme(
    light: AppThemes.cyan,
    dark: AppThemes.darkCyan,
  ),
  'green': CustomTheme(
    light: AppThemes.green,
    dark: AppThemes.darkGreen,
  ),
};
