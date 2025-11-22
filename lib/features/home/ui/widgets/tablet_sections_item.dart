import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/theme/app_assets.dart';
import 'package:flutter_quran_app/core/theme/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../data/app_sections_enum.dart';

class TabletSectionsItem extends StatelessWidget {
  const TabletSectionsItem({super.key, required this.section});
  final AppSection section;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      end: .98,
      onTap: () {
        section.push(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        height: 90.h,
        decoration: BoxDecoration(
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppAssets.imagesGreenColor),
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            const Spacer(flex: 2),
            Text(
              section.title,
              style: AppStyles.style28l,
            ),
            const Spacer(),
            VectorGraphic(
              loader: AssetBytesLoader(section.icon),
              fit: BoxFit.scaleDown,
              width: 75.w,
            ),
          ],
        ),
      ),
    );
  }
}
