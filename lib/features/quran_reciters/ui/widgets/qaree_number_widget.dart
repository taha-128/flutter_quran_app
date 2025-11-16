import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/int_extensions.dart';
import 'package:flutter_quran_app/core/helpers/extensions/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';

class NumberWidget extends StatelessWidget {
  const NumberWidget({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return GlassContainer.frostedGlass(
      width: 50.w,
      height: 50.w,
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(51, 255, 255, 255),
          Color.fromARGB(14, 255, 255, 255)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderGradient: const LinearGradient(
        colors: [
          Color.fromARGB(155, 255, 255, 255),
          Color.fromARGB(25, 255, 255, 255),
          Color.fromARGB(14, 64, 195, 255),
          Color.fromARGB(155, 64, 195, 255),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.39, 0.40, 1.0],
      ),
      borderRadius: BorderRadius.circular(18),
      alignment: Alignment.center,
      child: Center(
        child: Text(
          number.toArabicNums,
          style: context.headlineLarge,
        ),
      ),
    );
  }
}
