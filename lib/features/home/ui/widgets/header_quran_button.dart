// import 'package:flutter/material.dart';
// import 'package:flutter_quran_app/core/helpers/extensions/app_navigator.dart';
// import 'package:flutter_quran_app/features/quran/ui/quran_screen.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// class HeaderQuranButton extends StatelessWidget {
//   const HeaderQuranButton({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ZoomTapAnimation(
//       onTap: () {
//         context.push(const QuranScreen());
//       },
//       child: Container(
//         width: 40.w,
//         height: 40.w,
//         decoration: const BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: LinearGradient(
//             colors: [
//               Color.fromARGB(51, 255, 255, 255),
//               Color.fromARGB(14, 255, 255, 255)
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         padding: const EdgeInsets.all(6),
//         child: const Icon(
//           Icons.arrow_forward,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
