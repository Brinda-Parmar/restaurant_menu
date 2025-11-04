import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool>{

  ThemeCubit(bool isDark) : super(isDark);

  Future<void> toggleTheme() async {
    final sp = await SharedPreferences.getInstance();
    final newValue = !state;
    emit(newValue);
    await sp.setBool('isDarkTheme', newValue);
  }

  Future<void> loadTheme() async {
    final sp = await SharedPreferences.getInstance();
    final isDark = sp.getBool('isDarkTheme') ?? false;
    emit(isDark);
  }
}