import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../../data/entities/ride.dart';
import '../constants/city_coordinates.dart';

/// Reusable OpenStreetMap widget with route visualization
class TyvaaMap extends StatefulWidget {
  final LatLng? origin;
  final LatLng? destination;
  final List<LatLng>? routePoints;
  final List<Ride>? nearbyRides; // New: Show available rides on map
  final double? height;
  final bool showControls;
  final bool isInteractive;
  final Function(LatLng)? onMapTap;

  const TyvaaMap({
    super.key,
    this.origin,
    this.destination,
    this.routePoints,
    this.nearbyRides,
    this.height,
    this.showControls = false,
    this.isInteractive = true,
    this.onMapTap,
  });

  @override
  State<TyvaaMap> createState() => _TyvaaMapState();
}

class _TyvaaMapState extends State<TyvaaMap> {
  final MapController _mapController = MapController();

  static const LatLng _defaultCenter = LatLng(14.6928, -17.4467);

  List<Marker> get _markers {
    final markers = <Marker>[];

    // 1. Origin/Dest Markers (Blue/Green)
    if (widget.origin != null) {
      markers.add(
        Marker(
          point: widget.origin!,
          width: 40.w,
          height: 40.w,
          child: const Icon(
            Icons.location_on,
            color: AppColors.primary,
            size: 40,
          ),
        ),
      );
    }

    if (widget.destination != null) {
      markers.add(
        Marker(
          point: widget.destination!,
          width: 40.w,
          height: 40.w,
          child: const Icon(
            Icons.flag_rounded,
            color: AppColors.success,
            size: 40,
          ),
        ),
      );
    }

    // 2. Nearby Rides Markers (Small Car Icons) - Visual Cue!
    if (widget.nearbyRides != null) {
      for (var ride in widget.nearbyRides!) {
        final pos = CityCoordinates.get(ride.villeDepart);
        if (pos != null) {
          markers.add(
            Marker(
              point: pos,
              width: 32.w,
              height: 32.w,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(6.w),
                child: Image.asset(
                  'assets/icons/nav_rides.png',
                  color: AppColors.textMain,
                ),
              ),
            ),
          );
        }
      }
    }

    return markers;
  }

  List<Polyline> get _polylines {
    if (widget.routePoints == null || widget.routePoints!.length < 2) {
      if (widget.origin != null && widget.destination != null) {
        return [
          Polyline(
            points: [widget.origin!, widget.destination!],
            color: AppColors.textMain,
            strokeWidth: 4.0,
          ),
        ];
      }
      return [];
    }

    return [
      Polyline(
        points: widget.routePoints!,
        color: AppColors.textMain,
        strokeWidth: 4.0,
      ),
    ];
  }

  LatLng get _center {
    if (widget.origin != null) return widget.origin!;
    // If no specific origin, but we have rides, center on the first ride's city or default
    if (widget.nearbyRides != null && widget.nearbyRides!.isNotEmpty) {
      final firstPos = CityCoordinates.get(
        widget.nearbyRides!.first.villeDepart,
      );
      if (firstPos != null) return firstPos;
    }
    return _defaultCenter;
  }

  @override
  Widget build(BuildContext context) {
    Widget map = FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _center,
        initialZoom: 11.5, // Slightly zoomed out to show city context
        interactionOptions: InteractionOptions(
          flags: widget.isInteractive
              ? InteractiveFlag.all
              : InteractiveFlag.none,
        ),
        onTap: widget.onMapTap != null
            ? (_, latLng) => widget.onMapTap!(latLng)
            : null,
      ),
      children: [
        TileLayer(
          // CartoDB Voyager: Clean, modern, and colorful (Premium look)
          // Much better than the monochrome "Positron" style
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.tyvaa.flutter_tyvaa',
        ),
        PolylineLayer(polylines: _polylines),
        MarkerLayer(markers: _markers),
      ],
    );

    if (widget.height != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: SizedBox(height: widget.height!.h, child: map),
      );
    }

    return map;
  }
}
