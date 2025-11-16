import '../../../core/theme/app_assets.dart';

enum AppSection {
  quran(
    icon: AppAssets.svgsQuranSectionIcon,
    title: 'القرآن الكريم',
  ),
  readers(
    icon: AppAssets.svgsRecitersSectionIcon,
    title: 'القــــــــــــــــــراء',
  ),

  azkar(
    icon: AppAssets.svgsAzkarSectionIcon,
    title: 'الأذكــــــــــــــــــار',
  ),
  qiblah(
    icon: AppAssets.svgsQiblahSectionIcon,
    title: 'القــــــــــــــــــبلة',
  ),
  prayersTime(
    icon: AppAssets.svgsPrayerTimesSectionIcon,
    title: 'أوقات الصـلاة',
  ),
  ;

  final String icon, title;

  const AppSection({required this.icon, required this.title});
}
