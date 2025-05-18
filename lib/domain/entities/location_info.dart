class LocationInfo {
  final String placeId;
  final String osmId;
  final String osmType;
  final double lat;
  final double lon;
  final String displayName;
  final String displayPlace;
  final String displayAddress;
  final String category;
  final String type;
  final AddressInfo address;

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
    required this.address,
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
      address: AddressInfo.fromJson(json['address']),
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
      'address': address.toJson(),
    };
  }
}

class AddressInfo {
  final String? name;
  final String? suburb;
  final String? city;
  final String? county;
  final String? state;
  final String? country;
  final String? countryCode;

  AddressInfo({
    this.name,
    this.suburb,
    this.city,
    this.county,
    this.state,
    this.country,
    this.countryCode,
  });

  factory AddressInfo.fromJson(Map<String, dynamic> json) {
    return AddressInfo(
      name: json['name'],
      suburb: json['suburb'],
      city: json['city'],
      county: json['county'],
      state: json['state'],
      country: json['country'],
      countryCode: json['country_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'suburb': suburb,
      'city': city,
      'county': county,
      'state': state,
      'country': country,
      'country_code': countryCode,
    };
  }
}
