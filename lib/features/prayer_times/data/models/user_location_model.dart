class UserLocationModel {
  final String country, city, address, arabicAddress;
  final String isoCode;
  final int? method;

  UserLocationModel({
    required this.arabicAddress,
    required this.address,
    required this.isoCode,
    required this.country,
    required this.method,
    required this.city,
  });

}
