// import 'package:flutter/material.dart';
// import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
// import 'package:flutter_quran_app/core/helpers/extensions/theme.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'header_quran_button.dart';

// class HeaderQuranWidgetMobile extends StatelessWidget {
//   const HeaderQuranWidgetMobile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       width: context.screenWidth,
//       height: 170.h,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [
//             Color.fromARGB(230, 139, 195, 74),
//             Color.fromARGB(165, 139, 195, 74),
//             Color.fromARGB(130, 139, 195, 74),
//           ],
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//         ),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(width: 8.h),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'القرآن الكريم',
//                   style: context.headlineLarge,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 6.h),
//                 const HeaderQuranButton()
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
