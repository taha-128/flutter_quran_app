import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quran_app/features/prayer_times/data/models/prayer_times_model.dart';
import 'package:flutter_quran_app/features/prayer_times/data/models/user_location_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/repo/prayer_times_repo.dart';

part 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit(this._repo) : super(PrayerTimesInitial()) {
    getPrayerTimes();
  }
  final PrayerTimesRepo _repo;
  PrayerTimesResponseModel? prayers;

  Future<UserLocationModel?> getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      GeocodingPlatform.instance!.setLocaleIdentifier('en');

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;
      String? address = place.street;

      if (place.isoCountryCode == 'EG') {
        address =
            '${place.administrativeArea ?? place.locality}, ${place.country}';
      } else if (place.isoCountryCode == 'SA') {
        address =
            '${place.subAdministrativeArea ?? place.locality}, ${place.administrativeArea ?? place.locality}, ${place.country}';
      }

      GeocodingPlatform.instance!.setLocaleIdentifier('ar');

      List<Placemark> arabicPlacemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      return UserLocationModel(
        arabicAddress: arabicPlacemarks.first.street!,
        address: address!,
        country: place.country!,
        city: place.administrativeArea ?? place.locality!,
        isoCode: place.isoCountryCode!,
        method: place.isoCountryCode == 'SA' ? 4 : null,
      );
    } catch (e) {
      emit(
        PrayerTimesFailure(
          errMessage: 'عذرًا لا نستطيع تحديد مواعيد الصلاة في موقعك',
        ),
      );
    }
    return null;
  }

  Future<void> getPrayerTimes() async {
    emit(PrayerTimesLoading());
    UserLocationModel? location = await getUserLocation();
    if (location == null) {
      emit(
        PrayerTimesFailure(
          errMessage: 'عذرًا لا نستطيع تحديد مواعيد الصلاة في موقعك',
        ),
      );
      return;
    }

    prayers = await _repo.getCachedPrayers(location: location);

    if (prayers != null) {
      emit(PrayerTimesSuccess());
      return;
    }

    try {
      if (location.isoCode == 'EG') {
        prayers = await _repo.getByCity(location);
      } else {
        prayers = await _repo.getByAddress(location);
      }
      emit(PrayerTimesSuccess());
    } catch (e) {
      emit(
        PrayerTimesFailure(
          errMessage:
              'حدث خطأ ما يرجى التأكد من الاتصال بالانترنت: ${e.toString()}',
        ),
      );
    }
  }
}
