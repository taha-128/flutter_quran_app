import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quran_app/core/helpers/alert_helper.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/theme/app_assets.dart';
import 'package:flutter_quran_app/core/theme/app_colors.dart';
import 'package:flutter_quran_app/core/theme/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/di/di.dart';
import '../logic/prayer_times_cubit/prayer_times_cubit.dart';
import 'widgets/prayer_times_screen_body_builder.dart';

// enum PrayerTimes { fajr, shrouk, duhur, asr, maghrib, isha }

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen>
    with WidgetsBindingObserver {
  bool hasPermission = false;
  bool serviceEnabled = true;
  bool permissionPermanentlyDenied = false;

  Future<void> _refreshStatus() async {
    final service = await Geolocator.isLocationServiceEnabled();
    // final status = await Permission.location.status;
    setState(() {
      serviceEnabled = service;
      // hasPermission = status.isGranted;
      // permissionPermanentlyDenied = status.isPermanentlyDenied;
    });
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          AlertHelper.showWarningAlert(
            context,
            message: 'تم رفض صلاحية الموقع. لن تعمل مواعيد الصلاة تلقائيًا.',
          );
        }
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        AlertHelper.showWarningAlert(
          context,
          message: 'الرجاء تفعيل صلاحية الموقع من الإعدادات.',
        );
      }
      permissionPermanentlyDenied = true;
    }
    setState(() {
      hasPermission = true;
    });
    // final result = await Permission.location.request();
    // await _refreshStatus();
    // if (result.isGranted) {
    //   AlertHelper.showSuccessAlert(context, message: 'تم منح صلاحية الموقع.');
    // } else if (result.isPermanentlyDenied) {
    //   AlertHelper.showWarningAlert(
    //     context,
    //     message: 'الرجاء تفعيل صلاحية الموقع من الإعدادات.',
    //   );
    // } else {
    //   AlertHelper.showWarningAlert(
    //     context,
    //     message: 'تم رفض صلاحية الموقع. لن تعمل مواعيد الصلاة تلقائيًا.',
    //   );
    // }
  }

  Future<void> _openLocationSettings() async {
    final opened = await Geolocator.openLocationSettings();
    if (!opened) return;
    await _refreshStatus();
  }

  Future<void> _openAppSettings() async {
    final opened = await openAppSettings();
    if (!opened) return;
    await _refreshStatus();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshStatus();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshStatus();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          if (!serviceEnabled) {
            return _PermissionPanel(
              icon: Icons.location_disabled,
              title: 'خدمة الموقع متوقفة',
              message:
                  'فعّل خدمة الموقع من شريط الإشعارات أو الإعدادات لتحديد اتجاه القبلة.',
              primaryLabel: 'فتح إعدادات الموقع',
              onPrimaryPressed: _openLocationSettings,
              secondaryLabel: 'تحديث الحالة',
              onSecondaryPressed: _refreshStatus,
            );
          }

          if (!hasPermission && permissionPermanentlyDenied) {
            return _PermissionPanel(
              icon: Icons.lock,
              title: 'الصلاحية مرفوضة دائمًا',
              message:
                  'لا يمكن عرض مواعيد الصلاة بدون صلاحية الموقع. افتح الإعدادات ومنح الإذن.',
              primaryLabel: 'فتح إعدادات التطبيق',
              onPrimaryPressed: _openAppSettings,
              secondaryLabel: 'تحديث الحالة',
              onSecondaryPressed: _refreshStatus,
            );
          }

          if (!hasPermission) {
            return _PermissionPanel(
              icon: Icons.location_on,
              title: 'مطلوب صلاحية الموقع',
              message:
                  'نستخدم موقعك لجلب مواعيد الصلاة لمنطقتك. الرجاء منح الإذن للمتابعة.',
              primaryLabel: 'منح الإذن',
              onPrimaryPressed: _requestPermission,
              secondaryLabel: 'تحديث الحالة',
              onSecondaryPressed: _refreshStatus,
            );
          }

          return SizedBox(
            width: context.screenWidth,
            height: context.screenHeight,
            child: BlocProvider(
              create: (_) => PrayerTimesCubit(getIt()),
              child: const PrayerTimesScreenBodyBuilder(),
            ),
          );
        },
      ),
    );
  }
}

class _PermissionPanel extends StatelessWidget {
  final IconData icon;
  final String title;

  final String message;
  final String primaryLabel;
  final VoidCallback onPrimaryPressed;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryPressed;

  const _PermissionPanel({
    required this.icon,
    required this.title,
    required this.message,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    this.secondaryLabel,
    this.onSecondaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppAssets.imagesFullWhiteBackground),
        ),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 64, color: AppColors.green),
              SizedBox(height: 16.h),
              Text(
                title,
                style: AppStyles.style22u.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                message,
                style: AppStyles.style16.copyWith(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPrimaryPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: context.isTablet ? 8 : 0),
                    child: Text(
                      primaryLabel,
                      style: AppStyles.style16.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              if (secondaryLabel != null && onSecondaryPressed != null) ...[
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onSecondaryPressed,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: context.isTablet ? 8 : 0),
                      child: Text(
                        secondaryLabel!,
                        style: AppStyles.style16.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
