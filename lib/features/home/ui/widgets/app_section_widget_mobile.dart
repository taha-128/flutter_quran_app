import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/helpers/extensions/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/app_sections_enum.dart';

class AppSectionWidgetMobile extends StatelessWidget {
  const AppSectionWidgetMobile({super.key, required this.data});
  final AppSection data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(51, 255, 255, 255),
            Color.fromARGB(14, 255, 255, 255)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      width: context.screenWidth * .4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            overflow: TextOverflow.ellipsis,
            style: context.headlineLarge,
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              data.icon,
              height: 80.h,
            ),
          ),
        ],
      ),
    );
  }
}
