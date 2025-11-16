import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/int_extensions.dart';
import 'package:flutter_quran_app/core/helpers/extensions/theme.dart';
import 'package:quran/quran.dart';

class FullPageDetailsMobile extends StatelessWidget {
  const FullPageDetailsMobile(
      {super.key, required this.surahNumber, required this.firstVerse});
  final int surahNumber, firstVerse;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getJuzNumber(surahNumber, firstVerse).toJuzName,
          style: context.labelSmall,
        ),
        Text(
          'سورة ${getSurahNameArabic(surahNumber)}',
          style: context.labelSmall,
        ),
      ],
    );
  }
}

// class MinPageDetailsMobile extends StatelessWidget {
//   const MinPageDetailsMobile({super.key, required this.surahNumber});
//   final int surahNumber;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           getJuzNumber(surahNumber, 1).toJuzName,
//           style: context.labelSmall.copyWith(fontSize: 15.sp),
//         ),
//         Text(
//           'سورة ${getSurahNameArabic(surahNumber)}',
//           style: context.labelSmall.copyWith(fontSize: 15.sp),
//         ),
//       ],
//     );
//   }
// }
