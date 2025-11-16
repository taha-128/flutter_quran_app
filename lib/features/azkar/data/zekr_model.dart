class ZekrModel {
  final String zekr, bless;
  final int repeat;

  ZekrModel({required this.zekr, required this.bless, required this.repeat});

  factory ZekrModel.fromJson(Map<String, dynamic> json) {
    return ZekrModel(
      zekr: json['zekr'],
      bless: json['bless'],
      repeat: json['repeat'],
    );
  }

  @override
  String toString() {
    if (bless.isNotEmpty) {
      return 'الذكر: $zekr\n التكرار:$repeat\n الجزاء: $bless';
    } else {
      return 'الذكر: $zekr\n التكرار:$repeat\n';
    }
  }
}
