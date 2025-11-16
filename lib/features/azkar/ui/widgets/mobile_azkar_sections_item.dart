import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/app_navigator.dart';
import 'package:flutter_quran_app/core/theme/app_assets.dart';
import 'package:flutter_quran_app/core/theme/app_styles.dart';
import 'package:flutter_quran_app/features/azkar/ui/azkar_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../azkar/ui/azkar_sections_screen.dart';

class MobileAzkarSectionsItem extends StatelessWidget {
  const MobileAzkarSectionsItem({
    super.key,
    required this.section,
  });
  final AzkarSection section;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      end: .98,
      onTap: () {
        context.push(AzkarScreen(section: section),
            direction: NavigationDirection.upToDown);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        height: 100.h,
        decoration: BoxDecoration(
          image: const DecorationImage(
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
            image: AssetImage(AppAssets.imagesGreenColor),
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            const Spacer(),
            Text(
              section.title,
              style: AppStyles.style28l,
            ),
            const Spacer(),
            SvgPicture.asset(
              section.icon,
              width: 80.w,
            )
          ],
        ),
      ),
    );
  }
}
