import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantmenuapp/logic/cart_bloc/cart_bloc.dart';
import 'package:restaurantmenuapp/logic/cart_bloc/cart_event.dart';
import 'package:restaurantmenuapp/logic/menu_bloc/menu_bloc.dart';
import 'package:restaurantmenuapp/logic/menu_bloc/menu_event.dart';
import 'package:restaurantmenuapp/logic/theme_cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/themes/dark_theme.dart';
import 'core/themes/light_theme.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  runApp(MyApp(isDark: isDarkMode));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit(isDark)),
        BlocProvider(create: (context) => MenuBloc()..add(LoadMenuEvent())),
        BlocProvider(create: (context) => CartBloc()..add(LoadCartEvent()),),

        
      ],
      child:  BlocBuilder<ThemeCubit, bool>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Restaurant App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state ? ThemeMode.dark : ThemeMode.light,
            home: const HomePage(),
          );
       },
      )
    );
  }
}
