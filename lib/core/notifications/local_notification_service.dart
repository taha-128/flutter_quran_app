// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:timezone/data/latest.dart' as tzdata;
// import 'package:timezone/timezone.dart' as tz;

// class LocalNotificationService {
//   LocalNotificationService._internal();
//   static final LocalNotificationService _instance =
//       LocalNotificationService._internal();
//   static LocalNotificationService get instance => _instance;

//   final FlutterLocalNotificationsPlugin _plugin =
//       FlutterLocalNotificationsPlugin();
//   bool _initialized = false;

//   static const AndroidNotificationChannel _defaultChannel =
//       AndroidNotificationChannel(
//     'default_notifications_channel',
//     'General Notifications',
//     description: 'General notifications for the Quran app',
//     importance: Importance.defaultImportance,
//   );

//   Future<void> initialize() async {
//     if (_initialized) return;

//     const AndroidInitializationSettings androidInit =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );

//     const InitializationSettings initSettings = InitializationSettings(
//       android: androidInit,
//       iOS: iosInit,
//     );

//     await _plugin.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         if (kDebugMode) {
//           // ignore: avoid_print
//           print('Notification tapped: ${response.payload}');
//         }
//       },
//       onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//     );

//     // Initialize time zones for zoned scheduling
//     tzdata.initializeTimeZones();

//     // Android: create default channel
//     if (Platform.isAndroid) {
//       final AndroidFlutterLocalNotificationsPlugin? android =
//           _plugin.resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>();
//       await android?.createNotificationChannel(_defaultChannel);
//     }

//     _initialized = true;
//   }

//   Future<bool> requestPermissions() async {
//     final status = await Permission.notification.request();
//     return status.isGranted;
//   }

//   Future<void> showImmediate({
//     required int id,
//     required String title,
//     required String body,
//     String? payload,
//     String? androidChannelId,
//     String? androidChannelName,
//     String? androidChannelDescription,
//     Importance androidImportance = Importance.defaultImportance,
//     Priority androidPriority = Priority.defaultPriority,
//   }) async {
//     await initialize();
//     final NotificationDetails details = await _buildDetails(
//       channelId: androidChannelId,
//       channelName: androidChannelName,
//       channelDescription: androidChannelDescription,
//       importance: androidImportance,
//       priority: androidPriority,
//     );
//     await _plugin.show(id, title, body, details, payload: payload);
//   }

//   Future<void> scheduleAt({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime dateTime,
//     String? payload,
//     String? androidChannelId,
//     String? androidChannelName,
//     String? androidChannelDescription,
//     Importance androidImportance = Importance.defaultImportance,
//     Priority androidPriority = Priority.defaultPriority,
//     DateTimeComponents? matchDateTimeComponents,
//   }) async {
//     await initialize();
//     final NotificationDetails details = await _buildDetails(
//       channelId: androidChannelId,
//       channelName: androidChannelName,
//       channelDescription: androidChannelDescription,
//       importance: androidImportance,
//       priority: androidPriority,
//     );
//     final tz.TZDateTime tzDate = tz.TZDateTime.from(dateTime, tz.local);
//     await _plugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tzDate,
//       details,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       matchDateTimeComponents: matchDateTimeComponents,
//       payload: payload,
//     );
//   }

//   Future<void> cancel(int id) async {
//     await _plugin.cancel(id);
//   }

//   Future<void> cancelAll() async {
//     await _plugin.cancelAll();
//   }

//   Future<NotificationDetails> _buildDetails({
//     String? channelId,
//     String? channelName,
//     String? channelDescription,
//     Importance importance = Importance.defaultImportance,
//     Priority priority = Priority.defaultPriority,
//   }) async {
//     final AndroidNotificationDetails android = AndroidNotificationDetails(
//       channelId ?? _defaultChannel.id,
//       channelName ?? _defaultChannel.name,
//       channelDescription: channelDescription ?? _defaultChannel.description,
//       importance: importance,
//       priority: priority,
//       playSound: true,
//       enableVibration: true,
//       styleInformation: const DefaultStyleInformation(true, true),
//     );

//     const DarwinNotificationDetails ios = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     return NotificationDetails(android: android, iOS: ios);
//   }
// }

// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse response) {
//   if (kDebugMode) {
//     // ignore: avoid_print
//     print('Background notification tapped: ${response.payload}');
//   }
// }
