// class AppSectionWidgetTablet extends StatelessWidget {
//   const AppSectionWidgetTablet({super.key, required this.data});
//   final AppSection data;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [
//             Color.fromARGB(51, 255, 255, 255),
//             Color.fromARGB(14, 255, 255, 255)
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         color: context.surfaceColor,
//         borderRadius: BorderRadius.circular(24),
//       ),
//       width: context.screenWidth * .38,
//       child: Column(
//         // mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             data.title,
//             overflow: TextOverflow.ellipsis,
//             style: context.headlineLarge,
//           ),
//           const Spacer(),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: SvgPicture.asset(
//               data.icon,
//               height: 90.h,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
