import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:tugas_1/core/constants/app_colors.dart';

/// Model for custom map marker pins
class MapMarkerItem {
  final LatLng point;
  final String title;
  final String? subtitle;
  final Color pinColor;
  final IconData icon;
  final bool showBadge;
  final VoidCallback? onTap;

  const MapMarkerItem({
    required this.point,
    required this.title,
    this.subtitle,
    this.pinColor = AppColors.primary,
    this.icon = Icons.location_on,
    this.showBadge = true,
    this.onTap,
  });
}

/// Model for route lines drawn on the map
class MapRouteData {
  final List<LatLng> points;
  final Color color;
  final double strokeWidth;
  final bool isDotted;

  const MapRouteData({
    required this.points,
    this.color = AppColors.primary,
    this.strokeWidth = 4.0,
    this.isDotted = false,
  });
}
