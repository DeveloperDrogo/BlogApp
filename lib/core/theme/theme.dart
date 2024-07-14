import 'package:clean/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class Apptheme {

  static border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      // [Color color = AppPallete.borderColor] means default take  AppPallete.borderColor this color
      borderSide: BorderSide(
        color: color,
        width: 3,
      ),
      borderRadius: BorderRadius.circular(10));

  static final darkModeTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(27),
          enabledBorder: border(),
          focusedBorder: border(AppPallete.gradient2)));
}
