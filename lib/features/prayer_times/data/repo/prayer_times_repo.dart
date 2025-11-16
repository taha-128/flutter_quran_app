import 'package:flutter_quran_app/core/app_constants.dart';
import 'package:flutter_quran_app/core/services/cache_service.dart';
import 'package:flutter_quran_app/features/prayer_times/data/models/prayer_times_model.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/di.dart';
import '../../../../core/networking/api_keys.dart';
import '../../../../core/networking/dio_consumer.dart';
import '../../../../core/services/prayer_times_cache.dart';
import '../models/user_location_model.dart';

class PrayerTimesRepo {
  // PrayerTimesResponseModel? _lastFetched;

  Future<PrayerTimesResponseModel> getByCity(UserLocationModel location) async {
    getIt<CacheService>().setString(
      AppConsts.locationMethod,
      AppConsts.byCity,
    );

    final now = DateTime.now();
    final dayKey = DateFormat('dd-MM-yyyy').format(now);
    var response = await getIt<DioConsumer>().get(
      '${ApiKeys.prayerTimesByCityBaseUrl}/$dayKey',
      headers: {'content-type': 'application/json'},
      queryParameters: {
        ApiKeys.country: location.country,
        ApiKeys.city: location.city,
        ApiKeys.method: location.method,
      },
    );
    // getIt<CacheService>().setString(
    //   AppConsts.country,
    //   location.country,
    // );
    // getIt<CacheService>().setString(
    //   AppConsts.city,
    //   location.city,
    // );

    final data = response['data'] as Map<String, dynamic>;
    await cachePrayerTimes(data, address: location.address);

    final model = PrayerTimesResponseModel.fromJson(
      data,
      location: location,
    );
    // _lastFetched = model;
    // Fire-and-forget scheduling (doesn't block fetch)
    // ignore: unawaited_futures
    // scheduleNotifications();
    return model;
  }

  Future<PrayerTimesResponseModel> getByAddress(
    UserLocationModel location,
  ) async {
    // getIt<CacheService>().setString(
    //   AppConsts.locationMethod,
    //   AppConsts.byAddress,
    // );

    final now = DateTime.now();
    final dayKey = DateFormat('dd-MM-yyyy').format(now);
    var response = await getIt<DioConsumer>().get(
      '${ApiKeys.prayerTimesByAddressBaseUrl}/$dayKey',
      headers: {'content-type': 'application/json'},
      queryParameters: {
        ApiKeys.address: location.address,
        ApiKeys.method: location.method,
      },
    );
    // getIt<CacheService>().setString(
    //   AppConsts.address,
    //   location.address,
    // );
    final data = response['data'] as Map<String, dynamic>;

    await cachePrayerTimes(data, address: location.address);

    final model = PrayerTimesResponseModel.fromJson(
      data,
      location: location,
    );
    // _lastFetched = model;
    // Fire-and-forget scheduling (doesn't block fetch)
    // ignore: unawaited_futures
    // scheduleNotifications();
    return model;
  }

  Future<void> cachePrayerTimes(
    Map<String, dynamic> dataForDay, {
    required String address,
  }) async {
    final dayKey = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final cacheKey = '$dayKey|$address';
    await PrayerTimesCache.putEntry(cacheKey, {
      'timings': dataForDay['timings'],
      'date': dataForDay['date'],
    });
  }

  Future<PrayerTimesResponseModel?> getCachedPrayers({
    required UserLocationModel location,
  }) async {
    final todayKey = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final cacheKey = '$todayKey|${location.address}';
    final cached = await PrayerTimesCache.getEntry(cacheKey);
    if (cached == null) return null;

    try {
      final timings = cached['timings'] as Map<String, dynamic>?;
      final date = cached['date'] as Map<String, dynamic>?;
      if (timings == null || date == null) return null;
      final modelJson = {
        'timings': timings,
        'date': date,
      };
      return PrayerTimesResponseModel.fromJson(modelJson, location: location);
    } catch (_) {
      return null;
    }
  }

  // Future<void> scheduleNotifications() async {
  //   final model = _lastFetched;
  //   if (model == null) return;

  //   final now = DateTime.now();
  //   final String ymd = DateFormat('yyyyMMdd').format(now);
  //   int baseId = int.parse(ymd) * 100; // Room for multiple notifications

  //   // Optionally clear previous ones for today (simple approach: cancel all)
  //   // If you prefer finer-grained control, track IDs you create and cancel those only.
  //   // await LocalNotificationService.instance.cancelAll();

  //   int i = 1;
  //   for (final pt in model.prayerTimes) {
  //     if (pt.date.isAfter(now)) {
  //       final id = baseId + i;
  //       final title = 'موعد صلاة ${pt.title}';
  //       final body =
  //           'حان وقت صلاة ${pt.title} في ${DateFormat('HH:mm').format(pt.date)}';
  //       await LocalNotificationService.instance.scheduleAt(
  //         id: id,
  //         title: title,
  //         body: body,
  //         dateTime: pt.date,
  //         androidChannelId: 'prayer_times_channel',
  //         androidChannelName: 'Prayer Times',
  //         androidChannelDescription: 'Prayer time reminders',
  //         androidImportance: Importance.max,
  //         androidPriority: Priority.high,
  //       );
  //     }

  //     // Optionally schedule iqama notification (uncomment if desired):
  //     // if (pt.iqamaDate.isAfter(now)) {
  //     //   final iqamaId = baseId + 50 + i;
  //     //   await LocalNotificationService.instance.scheduleAt(
  //     //     id: iqamaId,
  //     //     title: 'إقامة صلاة ${pt.title}',
  //     //     body: 'إقامة صلاة ${pt.title} عند ${DateFormat('HH:mm').format(pt.iqamaDate)}',
  //     //     dateTime: pt.iqamaDate,
  //     //     androidChannelId: 'prayer_times_channel',
  //     //     androidChannelName: 'Prayer Times',
  //     //     androidChannelDescription: 'Prayer time reminders',
  //     //     androidImportance: Importance.defaultImportance,
  //     //     androidPriority: Priority.defaultPriority,
  //     //   );
  //     // }

  //     i++;
  //   }
  // }
}
