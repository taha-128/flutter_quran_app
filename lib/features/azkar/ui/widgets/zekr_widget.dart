import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quran_app/core/app_constants.dart';
import 'package:flutter_quran_app/core/helpers/alert_helper.dart';
import 'package:flutter_quran_app/features/azkar/data/zekr_model.dart';
import 'package:flutter_quran_app/features/azkar/ui/widgets/zekr_counter_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class ZekrWidget extends StatelessWidget {
  const ZekrWidget({
    super.key,
    required this.zekr,
    required this.currentCount,
    required this.onIncrement,
  });

  final ZekrModel zekr;
  final int currentCount;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onIncrement,
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: zekr.toString()));
        AlertHelper.showSuccessAlert(context, message: 'تم النسخ بنجاح');
      },
      child: Center(
        child: Container(
          width: 340.w,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding:
              EdgeInsets.only(right: 30.w, left: 30.w, top: 40.h, bottom: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectableText(
                zekr.zekr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  color: const Color(0xff606060),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppConsts.harmattan,
                ),
              ),
              if (zekr.bless.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SelectableText(
                    zekr.bless,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontFamily: AppConsts.harmattan,
                      fontWeight: FontWeight.w500,
                      color: AppColors.green,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              ZekrCounterWidget(
                currentCount: currentCount,
                targetRepeat: zekr.repeat,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
