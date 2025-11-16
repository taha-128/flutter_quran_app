import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/app_sections_enum.dart';
import 'mobile_sections_item.dart';

class MobileHomeSectionsList extends StatelessWidget {
  const MobileHomeSectionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      // padding: EdgeInsets.symmetric(
      //   horizontal: context.screenWidth * .1,
      // ),
      // physics: const BouncingScrollPhysics(),
      itemCount: AppSection.values.length,
      itemBuilder: (context, index) {
        return MobileSectionsItem(section: AppSection.values[index]);
      },
      separatorBuilder: (_, __) => SizedBox(height: 20.h),
    );
  }
}
