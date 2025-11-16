import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_assets.dart';
import '../theme/app_styles.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({super.key, required this.text, this.fontSize});

  final String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * .88,
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 20.w,
      ),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(AppAssets.imagesGreenColor),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: AppStyles.style26expo.copyWith(fontSize: fontSize),
        textAlign: TextAlign.center,
      ),
    );
  }
}
