import 'package:flutter/material.dart';

abstract class AppColors {
  static const runningTextRed = Color(0xFF4E1E1C);
  static const textBlue = Color(0xFF54DFE7);

  static const backGradientBegin = Color(0xFF3B1214);
  static const backGradientCenter = Color(0xFF110F14);
  static const backGradientEnd = Color(0xFF08151B);
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
  static const blender25Blue =
      TextStyle(fontFamily: 'blender', fontSize: 25, color: AppColors.textBlue);
}
