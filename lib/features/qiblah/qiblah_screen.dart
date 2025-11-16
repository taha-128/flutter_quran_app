// ignore_for_file: unused_import
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
// import 'package:flutter_quran_app/core/helpers/extensions/theme.dart';
import 'package:flutter_quran_app/core/widgets/top_bar_widget.dart';
import 'package:flutter_quran_app/features/qiblah/qiblah_compass.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/helpers/alert_helper.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_styles.dart';
import 'custom_compass.dart';

class QiblahScreen extends StatelessWidget {
  const QiblahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.screenHeight,
        width: context.screenWidth,
        child: Stack(
          children: [
            Image.asset(
              AppAssets.imagesWhiteBackground,
              fit: BoxFit.cover,
              height: double.infinity,
            ),
            Column(
              children: [
                TopBar(height: 280.h, label: 'القبلة'),
                const Spacer(),
                const QiblahCompass(),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
