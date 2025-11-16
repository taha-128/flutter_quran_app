import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quran_app/core/theme/app_assets.dart';
import 'package:flutter_quran_app/core/theme/theme_manager/theme_cubit.dart';
import 'package:flutter_quran_app/features/quran/bloc/quran/quran_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/mobile_quran_search_widget.dart';
import '../widgets/quran_fehres_dialog.dart';
import '../widgets/quran_surah_list.dart';
import '../widgets/theme_changer_dialog.dart';

class TabletQuranTopBar extends StatelessWidget {
  const TabletQuranTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuranCubit>();
    return Padding(
      padding: EdgeInsets.only(top: 22.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BlocProvider.value(
                          value: cubit,
                          child: const QuranFehresDialog(),
                        );
                      },
                    );
                  },
                  icon: SvgPicture.asset(AppAssets.svgsMenu, height: 30.h),
                ),
                const MobileQuranSearch(),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => BlocProvider.value(
                        value: context.read<ThemeCubit>(),
                        child: const ThemeChangerDialog(),
                      ),
                    );
                  },
                  icon: SvgPicture.asset(AppAssets.svgsSettings, height: 28.h),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80.h,
            width: double.infinity,
            child: const QuranSurahList(),
          ),
        ],
      ),
    );
  }
}
