import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/azkar_helper.dart';
import 'package:flutter_quran_app/core/theme/app_assets.dart';
import 'package:flutter_quran_app/core/widgets/custom_text_widget.dart';
import 'package:flutter_quran_app/features/azkar/data/zekr_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'azkar_sections_screen.dart';
import 'widgets/zekr_widget.dart';

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({super.key, required this.section});
  final AzkarSection section;

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  List<ZekrModel>? azkar;
  final Map<int, int> _counterValues = {};

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() async {
        azkar = await AzkarHelper.getAzkar(widget.section);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      azkar = await AzkarHelper.getAzkar(widget.section);
      setState(() {});
    });
  }

  void _incrementCounter(int index) {
    if (azkar != null && index < azkar!.length) {
      final currentCount = _counterValues[index] ?? 0;
      if (currentCount < azkar![index].repeat) {
        setState(() {
          _counterValues[index] = currentCount + 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.imagesFullWhiteBackground),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 65.h)),
            SliverToBoxAdapter(
              child: Center(
                child: CustomTextWidget(text: widget.section.title),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 18.h)),
            if (azkar != null)
              SliverList.separated(
                itemCount: azkar!.length,
                itemBuilder: (context, index) {
                  return ZekrWidget(
                    key: ValueKey('zekr_$index'),
                    zekr: azkar![index],
                    currentCount: _counterValues[index] ?? 0,
                    onIncrement: () => _incrementCounter(index),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 18),
              )
            else
              SliverFillRemaining(
                child: Lottie.asset(AppAssets.lottiesCircularIndicator),
              ),
            SliverToBoxAdapter(child: SizedBox(height: 30.h)),
          ],
        ),
      ),
    );
  }
}
