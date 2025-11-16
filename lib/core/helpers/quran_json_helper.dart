import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_quran_app/core/app_constants.dart';

class QuranJsonHelper {
  static late List jsonData;
  static Future<void> initQuranData() async {
    final String quranJson = await rootBundle.loadString(
      AppConsts.surahsJson,
    );

    jsonData = jsonDecode(quranJson);
  }
}
