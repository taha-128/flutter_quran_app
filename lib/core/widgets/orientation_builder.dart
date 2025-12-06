import 'package:flutter/material.dart';

class CustomOrientationBuilder extends StatelessWidget {
  const CustomOrientationBuilder({
    super.key,
    required this.portraitLayout,
    this.landscapeLayout,
  });
  final WidgetBuilder portraitLayout;
  final WidgetBuilder? landscapeLayout;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return portraitLayout(context);
    } else {
      if (landscapeLayout != null) {
        return landscapeLayout!(context);
      } else {
        return portraitLayout(context);
      }
    }
  }
}
