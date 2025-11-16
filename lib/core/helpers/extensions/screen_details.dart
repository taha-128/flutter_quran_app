import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/size_config.dart';

extension ScreenDetails on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  bool get isTablet => MediaQuery.sizeOf(this).width >= SizeConfig.tablet;
}
