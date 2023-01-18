import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}

class Constants {
  static const runningText =
      'マントラ-あなたは成功するでしょうマントラ-あなたは成功するでしょうマントラ-あなたは成功するでしょうマントラ-あなたは成功するでしょうマントラ-あなたは成功するでしょうマントラ-あなたは成功するでしょうマントラ-あなたは成功するでしょうマントラ-あなたは成功するでしょうマントラ-あなたは成功するでしょう';
}
