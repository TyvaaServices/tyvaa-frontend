
class LocationInfo {
  final String placeId;
  final String osmId;
  final String osmType;
  final double lat;
  final double lon;
  final String displayName;
  final String displayPlace;
  final String displayAddress;
  final String category; // 'class' in JSON
  final String type;

  LocationInfo({
    required this.placeId,
    required this.osmId,
    required this.osmType,
    required this.lat,
    required this.lon,
    required this.displayName,
    required this.displayPlace,
    required this.displayAddress,
    required this.category,
    required this.type,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      placeId: json['place_id'].toString(),
      osmId: json['osm_id'].toString(),
      osmType: json['osm_type'] ?? '',
      lat: double.tryParse(json['lat'] ?? '') ?? 0.0,
      lon: double.tryParse(json['lon'] ?? '') ?? 0.0,
      displayName: json['display_name'] ?? '',
      displayPlace: json['display_place'] ?? '',
      displayAddress: json['display_address'] ?? '',
      category: json['class'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'osm_id': osmId,
      'osm_type': osmType,
      'lat': lat.toString(),
      'lon': lon.toString(),
      'display_name': displayName,
      'display_place': displayPlace,
      'display_address': displayAddress,
      'class': category,
      'type': type,
    };
  }
}
