import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    loadTheme();
  }

  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      await prefs.setBool('isDark', true);
    } else {
      emit(ThemeMode.light);
      await prefs.setBool('isDark', false);
    }
  }

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;

    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}