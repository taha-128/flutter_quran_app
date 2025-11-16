// import 'package:flutter/material.dart';
// import 'package:flutter_quran_app/core/helpers/extensions/app_navigator.dart';
// import 'package:flutter_quran_app/features/home/ui/widgets/app_section_widget_tablet.dart';
// import 'package:flutter_quran_app/features/prayer_times/ui/prayer_times_screen.dart';
// import 'package:flutter_quran_app/features/qiblah/qiblah_screen.dart';
// import 'package:flutter_quran_app/features/quran_readers/ui/quran_readers_screen.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// import '../../../azkar/ui/azkar_sections_screen.dart';
// import 'home_bottom_section_mobile.dart';

// class HomeBottomSectionTablet extends StatelessWidget {
//   const HomeBottomSectionTablet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       physics: const BouncingScrollPhysics(),
//       itemCount: AppSection.values.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 30.h,
//         crossAxisSpacing: 30.w,
//       ),
//       itemBuilder: (context, index) {
//         return ZoomTapAnimation(
//           end: .96,
//           onTap: () {
//             switch (AppSection.values[index]) {
//               case AppSection.readers:
//                 context.push(const QuranReadersScreen());
//                 return;
//               case AppSection.azkar:
//                 context.push(const AzkarSectionsScreen());
//                 return;
//               case AppSection.prayersTime:
//                 context.push(const PrayerTimesScreen());
//                 return;
//               case AppSection.qiblah:
//                 context.push(const QiblahScreen());
//                 return;
//               case AppSection.quran:
//                 // TODO: Handle this case.
//                 throw UnimplementedError();
//             }
//           },
//           child: AppSectionWidgetTablet(data: AppSection.values[index]),
//         );
//       },
//     );
//   }
// }
