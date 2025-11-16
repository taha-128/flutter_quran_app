import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/prayer_times_model.dart';
import 'prayer_time_widget.dart';

class PrayerTimesGridView extends StatelessWidget {
  const PrayerTimesGridView(
      {super.key, required this.prayers, required this.nextPrayer});
  final PrayerTimesResponseModel prayers;
  final PrayerTimeModel nextPrayer;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: prayers.prayerTimes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 130.h,
        crossAxisSpacing: 16,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return PrayerTimeWidget(
          prayer: prayers.prayerTimes[index],
          isNextPrayer: prayers.prayerTimes[index].title == nextPrayer.title,
        );
      },
    );
  }
}
