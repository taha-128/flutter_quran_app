import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quran_app/core/helpers/extensions/theme.dart';
import 'package:flutter_quran_app/core/services/intro_service.dart';
import 'package:flutter_quran_app/core/theme/theme_manager/theme_cubit.dart';
import 'package:flutter_quran_app/features/quran/bloc/quran/quran_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';

import '../widgets/double_tap_dialog.dart';
import '../widgets/quran_pages_list.dart';
import 'min_page_rich_text_tablet.dart';
import 'tablet_min_quran_bottom_section.dart';
import 'tablet_quran_top_bar.dart';

class MinQuranTablet extends StatefulWidget {
  const MinQuranTablet({super.key, this.currecntPage});
  final int? currecntPage;

  @override
  State<MinQuranTablet> createState() => _MinQuranTabletState();
}

class _MinQuranTabletState extends State<MinQuranTablet> {
  @override
  void initState() {
    if (widget.currecntPage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<QuranCubit>().initControllers(widget.currecntPage!);
        _showIntroIfNeeded();
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showIntroIfNeeded();
      });
    }
    super.initState();
  }

  void _showIntroIfNeeded() {
    // Show intro tutorial only if it hasn't been shown before
    if (!IntroService.hasShownDoubleTapIntro()) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _showDoubleTapHint();
          // Mark as shown after starting
          IntroService.markDoubleTapIntroAsShown();
        }
      });
    }
  }

  void _showDoubleTapHint() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const DoubleTapDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          flex: 2,
          child: TabletQuranTopBar(),
        ),
        Expanded(
          flex: 7,
          child: GestureDetector(
            onDoubleTap: () {
              context.read<QuranCubit>().changeLayout();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: PageView.builder(
                controller: context.read<QuranCubit>().minQuranController,
                itemCount: totalPagesCount,
                onPageChanged: (value) {
                  context.read<QuranCubit>().onQuranPageChanged(value);
                },
                itemBuilder: (context, index) {
                  return BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return Container(
                        alignment: index > 1
                            ? index.isEven
                                ? Alignment.centerLeft
                                : Alignment.centerRight
                            : Alignment.center,
                        margin: EdgeInsets.only(left: index.isOdd ? 8 : 0),
                        decoration: BoxDecoration(
                          color: context.onPrimary,
                          borderRadius: borderRadius(index),
                          border: buildBorder(index),
                        ),
                        child: TabletMinPageRichText(pageNumber: index + 1),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: const TabletMinQuranBottomSection(),
                ),
              ),
              const Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: QuarnPagesList(),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }

  Border buildBorder(int index) {
    return Border(
      right: index.isOdd
          ? BorderSide(width: 2, color: context.onPrimary)
          : BorderSide.none,
      left: index.isEven
          ? BorderSide(width: 2, color: context.onPrimary)
          : BorderSide.none,
    );
  }

  BorderRadius borderRadius(int index) {
    return BorderRadius.horizontal(
      right:
          index.isEven ? const Radius.circular(12) : const Radius.circular(0),
      left: index.isOdd ? const Radius.circular(12) : const Radius.circular(0),
    );
  }
}
