import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantmenuapp/logic/theme_cubit/theme_cubit.dart';
import 'package:restaurantmenuapp/presentation/widgets/appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: commonAppBar(title: 'Settings'),
        body: Padding(padding: EdgeInsetsGeometry.all(10),
          child: BlocBuilder<ThemeCubit, bool>(builder: (context, state) {
            return SwitchListTile(
              title: Text('Dark Theme'),
              value: state,
              onChanged: (value) {
                context.read<ThemeCubit>().toggleTheme();
              },
            );
          },),
        ),

      ),
    );
  }
}

