import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/helpers/extensions/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'qaree_number_widget.dart';

class CustomListViewItem extends StatelessWidget {
  const CustomListViewItem({
    super.key,
    required this.index,
    required this.title,
    this.subTitle,
    this.customAsset,
    this.color,
  });
  final int index;
  final String title;
  final String? subTitle, customAsset;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Row(
        children: [
          NumberWidget(number: index + 1),
          SizedBox(width: 20.w),
          SizedBox(
            width: context.screenWidth * .55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: context.headlineLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                if (subTitle != null)
                  Text(
                    subTitle ?? '',
                    style: context.bodyMedium.copyWith(
                      color: Colors.grey.shade200,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    );
  }
}
