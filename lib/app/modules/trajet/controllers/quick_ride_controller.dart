import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart';

class QuickRideController extends GetxController {
  // Map controller
  final mapController = MapController();
  final endLocation = 'Medina'.obs;
  final startLocation = 'Pikine'.obs;

  // Observables
  final isLoading = true.obs;
  final currentLocation = Rx<LatLng?>(null);
  final destination = Rx<LatLng?>(null);
  final routePoints = <LatLng>[].obs;
  final markers = <Marker>[].obs;
  final polylines = <Polyline>[].obs;
  final bottomSheetVisible = true.obs;
  final zoom = 15.0.obs;

  // Ride information
  final estimatedPrice = "5000 FCFA".obs;
  final estimatedDistance = "3.2 km".obs;
  final estimatedDuration = "15 min".obs;
  final estimatedArrival = "12:45".obs;

  // Payment method
  final selectedPaymentMethod = "Cash".obs;

  // Dio client for API calls
  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
      currentLocation.value = LatLng(position.latitude, position.longitude);

      // Add marker for current location
      _addMarker(
        currentLocation.value!,
        "current_location",
        Icons.my_location,
        Colors.blue
      );

      // Mock destination - would be set based on user selection in a real app
      await Future.delayed(Duration(milliseconds: 500));
      setDestination(LatLng(
        currentLocation.value!.latitude + 0.01,
        currentLocation.value!.longitude + 0.01
      ));

      isLoading.value = false;
    } catch (e) {
      print("Error getting location: $e");
      isLoading.value = false;
    }
  }

  void setDestination(LatLng destinationPoint) {
    destination.value = destinationPoint;

    // Add marker for destination
    _addMarker(
      destinationPoint,
      "destination",
      Icons.location_on,
      AppColors.primary
    );

    // Get route between current location and destination
    _getRoutePoints();
  }

  void _addMarker(LatLng position, String markerId, IconData icon, Color color) {
    markers.add(
      Marker(
        width: 40.0,
        height: 40.0,
        point: position,
        child: Container(
          child: Icon(
            icon,
            color: color,
            size: 30,
          ),
        ),
      )
    );
  }

  void _getRoutePoints() async {
    if (currentLocation.value != null && destination.value != null) {
      try {
        isLoading.value = true;

        // Get route using OpenStreetMap Routing service (OSRM)
        final routeData = await _getRouteFromOSRM(
          currentLocation.value!,
          destination.value!
        );

        if (routeData != null) {
          // Update ride info based on route data
          double distanceInKm = routeData['distance'] / 1000;
          double durationInMin = routeData['duration'] / 60;

          estimatedDistance.value = "${distanceInKm.toStringAsFixed(1)} km";
          estimatedDuration.value = "${durationInMin.toStringAsFixed(0)} min";

          // Calculate price based on distance (simplified formula)
          int price = (distanceInKm * 300).round(); // 300 FCFA per km
          estimatedPrice.value = "${price.toString()} FCFA";

          // Create time of arrival
          final now = DateTime.now();
          final arrival = now.add(Duration(seconds: routeData['duration'].toInt()));
          estimatedArrival.value = "${arrival.hour}:${arrival.minute.toString().padLeft(2, '0')}";

          // Create polyline for the route
          _createPolyline(routeData['points']);

          // Zoom out to show both points
          _zoomToShowRoute();
        }
      } catch (e) {
        print("Error getting route: $e");
        // For demo purposes, create a straight line if routing fails
        List<LatLng> fallbackPoints = [currentLocation.value!, destination.value!];
        _createPolyline(fallbackPoints);
        _zoomToShowRoute();
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<Map<String, dynamic>?> _getRouteFromOSRM(LatLng start, LatLng end) async {
    try {
      // Use OpenStreetMap Routing Machine (OSRM) for routing with a timeout
      final response = await _dio.get(
        'https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}',
        queryParameters: {
          'overview': 'full',
          'geometries': 'polyline',
        },
        options: Options(
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['code'] == 'Ok' && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final distance = route['distance'] as num;
          final duration = route['duration'] as num;
          final geometry = route['geometry'] as String;

          // Decode the polyline
          List<LatLng> points = _decodePolyline(geometry);

          return {
            'distance': distance,
            'duration': duration,
            'points': points,
          };
        }
      }

      throw Exception("Invalid response from routing service");
    } catch (e) {
      print("OSRM API Error: $e");
      // Return fallback data instead of null to avoid getting stuck
      return {
        'distance': 3200, // 3.2 km
        'duration': 900,  // 15 minutes
        'points': [currentLocation.value!, destination.value!],
      };
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latitude = lat / 1E5;
      double longitude = lng / 1E5;
      points.add(LatLng(latitude, longitude));
    }
    return points;
  }

  void _createPolyline(List<LatLng> points) {
    polylines.clear();
    routePoints.value = points;

    polylines.add(
      Polyline(
        points: points,
        color: AppColors.primary,
        strokeWidth: 4.0,
      )
    );
  }

  void _zoomToShowRoute() {
    if (routePoints.isNotEmpty) {
      try {
        // Calculate bounds
        double minLat = routePoints.map((p) => p.latitude).reduce((a, b) => a < b ? a : b);
        double maxLat = routePoints.map((p) => p.latitude).reduce((a, b) => a > b ? a : b);
        double minLng = routePoints.map((p) => p.longitude).reduce((a, b) => a < b ? a : b);
        double maxLng = routePoints.map((p) => p.longitude).reduce((a, b) => a > b ? a : b);

        // Add padding
        double padding = 0.02;

        // Create bounds
        LatLngBounds bounds = LatLngBounds(
          LatLng(minLat - padding, minLng - padding),
          LatLng(maxLat + padding, maxLng + padding),
        );

        // Center and zoom the map to show the route
        // Using the correct method for the latest flutter_map version
        mapController.fitCamera(
          CameraFit.bounds(
            bounds: bounds,
            padding: const EdgeInsets.all(50.0),
          ),
        );
      } catch (e) {
        print("Error zooming to route: $e");

        // Fallback to simple centering
        if (currentLocation.value != null) {
          mapController.move(currentLocation.value!, 13);
        }
      }
    }
  }

  void requestRide() {
    Get.snackbar(
      'Ride Requested',
      'Your ride has been successfully requested. A driver will be assigned soon.',
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );

    // Here you would implement the API call to request the ride
  }

  void selectPaymentMethod(String? method) {
    if (method != null) {
      selectedPaymentMethod.value = method;
    }
  }
}
