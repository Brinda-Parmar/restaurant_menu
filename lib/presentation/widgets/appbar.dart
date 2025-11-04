import 'package:flutter/material.dart';
import 'package:restaurantmenuapp/core/themes/light_theme.dart';

AppBar commonAppBar({required String title}) {
  return AppBar(
    title: Text(title,style: TextStyle(color: Colors.white),),
    backgroundColor: lightTheme.primaryColor,
  );
}