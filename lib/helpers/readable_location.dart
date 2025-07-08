import 'package:geocoding/geocoding.dart';

class ReadableLocation {
  static Future<String> readableAddress({ required double lat, required double long}) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      lat,
      long,
    );
    return '${placemarks[0].locality == null || placemarks[0].locality!.isEmpty ? '' : '${placemarks[0].locality}'} ${(placemarks[0].subLocality == null || placemarks[0].subLocality!.isEmpty) ? '' : ', ${placemarks[0].subLocality}'}';
  }
}
