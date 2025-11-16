import 'package:flutter_quran_app/core/networking/dio_consumer.dart';
import 'package:flutter_quran_app/core/services/cache_service.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

import '../../features/prayer_times/data/repo/prayer_times_repo.dart';

final getIt = GetIt.instance;

setupGetIt() {
  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer());
  getIt.registerLazySingleton<AudioPlayer>(() => AudioPlayer());
  
  getIt.registerLazySingleton<PrayerTimesRepo>(() => PrayerTimesRepo());

  getIt.registerSingleton<CacheService>(CacheService());
}
