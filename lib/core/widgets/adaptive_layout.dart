import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';

import '../helpers/size_config.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    super.key,
    required this.mobileLayout,
    this.tabletLayout,
  });
  final WidgetBuilder mobileLayout;
  final WidgetBuilder? tabletLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (context.screenWidth < SizeConfig.tablet) {
          return mobileLayout(context);
        } else {
          if (tabletLayout != null) {
            return tabletLayout!(context);
          } else {
            return mobileLayout(context);
          }
        }
      },
    );
  }
}
