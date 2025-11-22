import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/features/home/ui/widgets/tablet_sections_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/app_sections_enum.dart';
import 'mobile_sections_item.dart';

class MobileHomeSectionsList extends StatelessWidget {
  const MobileHomeSectionsList({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isTablet) {
      return SliverList.separated(
        itemCount: AppSection.values.length,
        itemBuilder: (context, index) {
          return TabletSectionsItem(section: AppSection.values[index]);
        },
        separatorBuilder: (_, __) => SizedBox(height: 30.h),
      );
    } else {
      return SliverList.separated(
        itemCount: AppSection.values.length,
        itemBuilder: (context, index) {
          return MobileSectionsItem(section: AppSection.values[index]);
        },
        separatorBuilder: (_, __) => SizedBox(height: 20.h),
      );
    }
  }
}
