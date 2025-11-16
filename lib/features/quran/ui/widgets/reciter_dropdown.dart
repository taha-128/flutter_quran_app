import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/theme/app_colors.dart';
import 'package:flutter_quran_app/core/theme/app_styles.dart';
import 'package:flutter_quran_app/features/quran/bloc/verse_player/verse_player_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReciterDropdown extends StatefulWidget {
  final VersePlayerCubit cubit;

  const ReciterDropdown({
    super.key,
    required this.cubit,
  });

  @override
  State<ReciterDropdown> createState() => _ReciterDropdownState();
}

class _ReciterDropdownState extends State<ReciterDropdown> {
  String? selectedReciter;

  @override
  void initState() {
    super.initState();
    selectedReciter = widget.cubit.reciter ?? widget.cubit.reciters.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lime,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(
        //   color: context.primaryColor.withAlpha(77), // 0.3 opacity equivalent
        //   width: 1,
        // ),
        boxShadow: [
          BoxShadow(
            color: AppColors.lime.withAlpha(25), // 0.1 opacity equivalent
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedReciter,
          isExpanded: false,
          icon: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
              size: 20.sp,
            ),
          ),
          style: AppStyles.style16.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          items: widget.cubit.reciters.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Text(
                  entry.value,
                  style: AppStyles.style16.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null && newValue != selectedReciter) {
              setState(() {
                selectedReciter = newValue;
              });
              widget.cubit.changeReciter(newValue);
            }
          },
        ),
      ),
    );
  }
}
