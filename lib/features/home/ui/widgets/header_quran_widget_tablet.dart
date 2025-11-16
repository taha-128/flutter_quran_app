// import 'package:flutter/material.dart';
// import 'package:flutter_quran_app/core/helpers/extensions/app_navigator.dart';
// import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
// import 'package:flutter_quran_app/core/helpers/extensions/theme.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// import '../../../quran/ui/quran_screen.dart';

// class HeaderQuranWidgetTablet extends StatelessWidget {
//   const HeaderQuranWidgetTablet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
//       width: context.screenWidth,
//       // height: 170.h,
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
//           // Image.asset(
//           //   AppAssets.imagesHomeHeaderMoshaf,
//           //   fit: BoxFit.cover,
//           //   height: 120.h,
//           // ),
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
//                 SizedBox(height: 12.h),
//                 ZoomTapAnimation(
//                   onTap: () {
//                     context.push(const QuranScreen());
//                   },
//                   child: Container(
//                     width: 30.w,
//                     height: 30.w,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: LinearGradient(
//                         colors: [
//                           Color.fromARGB(51, 255, 255, 255),
//                           Color.fromARGB(14, 255, 255, 255)
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                     ),
//                     padding: const EdgeInsets.all(6),
//                     child: Icon(
//                       Icons.arrow_forward,
//                       color: Colors.white,
//                       size: 20.w,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
