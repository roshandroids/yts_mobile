import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';

final themeProvider = ChangeNotifierProvider<ThemeProvider>(
  (ref) => ThemeProvider(),
);

class ThemeProvider extends ChangeNotifier with WidgetsBindingObserver {
  ThemeProvider() {
    WidgetsBinding.instance.addObserver(this);
    brightness = SchedulerBinding.instance.window.platformBrightness;
  }
  ThemeMode? _thememode;

  late Brightness brightness;

  ThemeMode get getCurrentThemeMode => _thememode ?? ThemeMode.system;

  ThemeData get getLightThemeData => AppTheme.lightTheme;
  ThemeData get getDarkThemeData => AppTheme.darkTheme;

  bool get isDarkTheme => _isDarkTheme();

  ThemeData get getCurrentThemeData {
    if (_isDarkTheme()) {
      return getDarkThemeData;
    }
    return getLightThemeData;
  }

  bool _isDarkTheme() {
    switch (getCurrentThemeMode) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
        if (brightness == Brightness.light) {
          return false;
        }
        return true;
    }
  }

  void updateCurrentThemeMode(ThemeMode? updatedThemeMode) {
    _thememode = updatedThemeMode;
    notifyListeners();
  }

  @override
  void didChangePlatformBrightness() {
    brightness = SchedulerBinding.instance.window.platformBrightness;
    updateCurrentThemeMode(
      brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
    );
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
