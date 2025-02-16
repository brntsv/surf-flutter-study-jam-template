import 'package:flutter/material.dart';

abstract class AppColors {
  static const backGradientBegin = Color(0xFF3B1214);
  static const backGradientCenter = Color(0xFF110F14);
  static const backGradientEnd = Color(0xFF08151B);

  static const red = Color(0xFFFB484B);
  static const runningTextRed = Color(0xFF551E1D);
  static const textBlue = Color(0xFF54DFE7);
  static const textYellow = Color(0xFFF6EF00);
  static const textWhite = Color(0xFFE4E3E4);

  static const iconBlue = Color(0xFF54DFE7);
  static const btnBackRed = Color(0x40F44336);
  static const splashBlue = Color(0x6054DFE7);

  static const msgBackBlue = Color(0x6054DFE7);
  static const msgBrdOrange = Color(0xFFCE730A);
  static const msgBrdYellow = Color(0xFF352C03);
  static const backGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    stops: [0, 0.5, 1.0],
    colors: [
      AppColors.backGradientBegin,
      AppColors.backGradientCenter,
      AppColors.backGradientEnd,
    ],
  );
}

abstract class TxtStyle {
  static const runningLine =
      TextStyle(fontSize: 20.0, color: AppColors.runningTextRed);
  static const blender20Blue =
      TextStyle(fontFamily: 'blender', fontSize: 20, color: AppColors.textBlue);
  static const blender25Blue =
      TextStyle(fontFamily: 'blender', fontSize: 25, color: AppColors.textBlue);
  static const blender25Yellow = TextStyle(
      fontFamily: 'blender', fontSize: 25, color: AppColors.textYellow);

  ///content Red
  static const content14Red =
      TextStyle(fontSize: 14.0, fontFamily: 'play', color: AppColors.red);

  ///content Blue
  static const content14Blue =
      TextStyle(fontSize: 14.0, fontFamily: 'play', color: AppColors.textBlue);
  static const content20Blue =
      TextStyle(fontSize: 20.0, fontFamily: 'play', color: AppColors.textBlue);
  static const content24Blue =
      TextStyle(fontSize: 24.0, fontFamily: 'play', color: AppColors.textBlue);
  static const content32Blue =
      TextStyle(fontSize: 32.0, fontFamily: 'play', color: AppColors.textBlue);
  static const content56Blue =
      TextStyle(fontSize: 56.0, fontFamily: 'play', color: AppColors.textBlue);

  ///content Orange
  static const content14Orange = TextStyle(
      fontSize: 14.0, fontFamily: 'play', color: AppColors.textYellow);
  static const content20Orange = TextStyle(
      fontSize: 20.0, fontFamily: 'play', color: AppColors.textYellow);
}

final themeData = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
      filled: true,
      fillColor: AppColors.msgBackBlue,
      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
      errorStyle: TxtStyle.content20Blue.copyWith(color: AppColors.red),
      enabledBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: AppColors.red),
      ),
      border: const UnderlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Colors.transparent),
      ),
      errorBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: AppColors.red),
      ),
      labelStyle: TxtStyle.content24Blue),
);
