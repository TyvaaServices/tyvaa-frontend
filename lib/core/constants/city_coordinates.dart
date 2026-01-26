import 'package:latlong2/latlong.dart';

class CityCoordinates {
  static const Map<String, LatLng> locations = {
    'Dakar': LatLng(14.6928, -17.4467),
    'Saint-Louis': LatLng(16.0326, -16.4818),
    'Thiès': LatLng(14.7910, -16.9359),
    'Touba': LatLng(14.8665, -15.8767),
    'Ziguinchor': LatLng(12.5605, -16.2723),
    'Kaolack': LatLng(14.1667, -16.0833),
    'Mbour': LatLng(14.4220, -16.9638),
    'Louga': LatLng(15.6167, -16.2333),
    'Diourbel': LatLng(14.6500, -16.2333),
    'Tambacounda': LatLng(13.7680, -13.6670),
    'Kolda': LatLng(12.8833, -14.9500),
    'Fatick': LatLng(14.3500, -16.4000),
    'Kaffrine': LatLng(14.1053, -15.5564),
    'Matam': LatLng(15.6167, -13.3333),
    'Kédougou': LatLng(12.5500, -12.1833),
  };

  static LatLng? get(String cityName) {
    // Basic normalization
    final normalized = locations.keys.firstWhere(
      (k) => k.toLowerCase() == cityName.toLowerCase(),
      orElse: () => '',
    );
    if (normalized.isEmpty) return null;
    return locations[normalized];
  }
}
