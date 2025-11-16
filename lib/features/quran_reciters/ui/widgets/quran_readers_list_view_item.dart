import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/theme/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'qaree_number_widget.dart';

class ReadersListViewItem extends StatelessWidget {
  const ReadersListViewItem({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NumberWidget(number: index + 1),
        SizedBox(width: 15.w),
        SizedBox(
          width: context.screenWidth * .55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'محمد صديق المنشاوي',
                style: AppStyles.style20.copyWith(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              Text(
                'مجوّد',
                style: AppStyles.style20.copyWith(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const Spacer(),
        RotatedBox(
          quarterTurns: 2,
          child: Transform.scale(
            scale: 1.25,
            child: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ],
    );
  }
}
