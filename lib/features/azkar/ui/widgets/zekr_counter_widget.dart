import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/int_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class ZekrCounterWidget extends StatefulWidget {
  const ZekrCounterWidget({
    super.key,
    required this.currentCount,
    required this.targetRepeat,
  });

  final int currentCount;
  final int targetRepeat;

  @override
  State<ZekrCounterWidget> createState() => _ZekrCounterWidgetState();
}

class _ZekrCounterWidgetState extends State<ZekrCounterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  int _previousCount = 0;

  @override
  void initState() {
    super.initState();
    _previousCount = widget.currentCount;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCirc,
      ),
    );
  }

  @override
  void didUpdateWidget(ZekrCounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentCount != _previousCount) {
      _previousCount = widget.currentCount;
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 80.w,
                  height: 35.h,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: const Color(0xffE9E9E9),
                  ),
                ),
              ),
            ),
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                height: 50.w,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Center(
                  child: Container(
                    color: Colors.transparent,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: Text(
                        '${widget.targetRepeat.toArabicNums}/${widget.currentCount.toArabicNums}',
                        key: ValueKey<int>(widget.currentCount),
                        textAlign: TextAlign.center,
                        style: AppStyles.style20BFantezy,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
