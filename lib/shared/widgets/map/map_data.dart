import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:tugas_1/core/constants/app_colors.dart';
import 'package:tugas_1/shared/widgets/map/map_models.dart';

/// Predefined coordinates and sample transit routes for Jakarta & Greater Area (Jabodetabek).
class MapData {
  MapData._();

  // Common Tourist Destinations
  static const LatLng monas = LatLng(-6.175392, 106.827153);
  static const LatLng dufanAncol = LatLng(-6.125200, 106.833500);
  static const LatLng mojaMuseum = LatLng(-6.218500, 106.802600);
  static const LatLng oceanParkBsd = LatLng(-6.297400, 106.666900);
  static const LatLng kotaTua = LatLng(-6.135200, 106.813300);
  static const LatLng tmii = LatLng(-6.302400, 106.895200);
  static const LatLng ragunan = LatLng(-6.312400, 106.820100);

  // Transit & Route Points
  static const LatLng menteng = LatLng(-6.196800, 106.833000);
  static const LatLng klapanunggal = LatLng(-6.467800, 106.945500);
  static const LatLng cileungsi = LatLng(-6.402500, 106.958700);
  static const LatLng cibuburJunction = LatLng(-6.372500, 106.898800);
  static const LatLng transStudioCibubur = LatLng(-6.373900, 106.904800);
  static const LatLng halteBnn = LatLng(-6.244700, 106.871100);
  static const LatLng halteTosari = LatLng(-6.195600, 106.823100);
  static const LatLng stasiunManggarai = LatLng(-6.209900, 106.850200);
  static const LatLng stasiunJuanda = LatLng(-6.166600, 106.829900);

  /// Find destination LatLng by name, fallback to Monas
  static LatLng getDestinationCoordinate(String? title) {
    if (title == null) return monas;
    final lower = title.toLowerCase();
    if (lower.contains('dufan') || lower.contains('ancol')) return dufanAncol;
    if (lower.contains('moja')) return mojaMuseum;
    if (lower.contains('ocean park') || lower.contains('bsd')) return oceanParkBsd;
    if (lower.contains('kota tua')) return kotaTua;
    if (lower.contains('taman mini') || lower.contains('tmii')) return tmii;
    if (lower.contains('ragunan')) return ragunan;
    if (lower.contains('trans studio') || lower.contains('cibubur')) return transStudioCibubur;
    return monas;
  }

  /// Sample realistic transit route from Klapanunggal to Trans Studio Cibubur
  static List<LatLng> get klapanunggalToCibuburRoute => const [
        klapanunggal,
        LatLng(-6.442000, 106.951000),
        cileungsi,
        LatLng(-6.388000, 106.924000),
        cibuburJunction,
        transStudioCibubur,
      ];

  /// Sample realistic transit route from Menteng (Jakarta Pusat) to Destination (DUFAN / Monas)
  static List<LatLng> get mentengToDestinationRoute => const [
        menteng,
        LatLng(-6.195600, 106.823100), // Halte Tosari
        LatLng(-6.182000, 106.823000), // Bundaran HI / Sarinah
        LatLng(-6.175392, 106.827153), // Monas
        dufanAncol,
      ];

  /// Sample markers for Menteng route
  static List<MapMarkerItem> get mentengMarkers => const [
        MapMarkerItem(
          point: menteng,
          title: 'Asal: Menteng, Jakarta Pusat',
          pinColor: AppColors.accentOrange,
          icon: Icons.my_location,
        ),
        MapMarkerItem(
          point: halteTosari,
          title: 'Transit: Halte Tosari',
          pinColor: AppColors.primary,
          icon: Icons.directions_bus,
        ),
        MapMarkerItem(
          point: dufanAncol,
          title: 'Tujuan: Dunia Fantasi (DUFAN)',
          pinColor: AppColors.errorRed,
          icon: Icons.flag,
        ),
      ];

  /// Sample markers for Klapanunggal to Trans Studio Cibubur route
  static List<MapMarkerItem> get klapanunggalToCibuburMarkers => const [
        MapMarkerItem(
          point: klapanunggal,
          title: 'Asal: Klapanunggal',
          pinColor: AppColors.accentOrange,
          icon: Icons.my_location,
        ),
        MapMarkerItem(
          point: cibuburJunction,
          title: 'Transit: Halte Cibubur',
          pinColor: AppColors.primary,
          icon: Icons.directions_bus,
        ),
        MapMarkerItem(
          point: transStudioCibubur,
          title: 'Tujuan: Trans Studio Cibubur',
          pinColor: AppColors.errorRed,
          icon: Icons.flag,
        ),
      ];

  /// Corridor route points (Transjakarta Koridor 1 Blok M - Kota)
  static List<LatLng> get transjakartaCorridorRoute => const [
        LatLng(-6.2435, 106.7981), // Blok M
        LatLng(-6.2255, 106.8021), // Masjid Agung
        LatLng(-6.2185, 106.8026), // Gelora Bung Karno
        LatLng(-6.2088, 106.8188), // Dukuh Atas
        LatLng(-6.1956, 106.8231), // Tosari / Bundaran HI
        LatLng(-6.1824, 106.8235), // Sarinah
        LatLng(-6.1753, 106.8271), // Monas
        LatLng(-6.1666, 106.8299), // Juanda
        LatLng(-6.1352, 106.8133), // Kota
      ];

  /// Stop markers for Transjakarta corridor
  static List<MapMarkerItem> get transjakartaStops => const [
        MapMarkerItem(
          point: LatLng(-6.2435, 106.7981),
          title: 'Halte Blok M',
          icon: Icons.directions_bus,
          pinColor: AppColors.primary,
        ),
        MapMarkerItem(
          point: LatLng(-6.2185, 106.8026),
          title: 'Halte GBK Senayan',
          icon: Icons.directions_bus,
          pinColor: AppColors.primary,
        ),
        MapMarkerItem(
          point: LatLng(-6.1956, 106.8231),
          title: 'Halte Bundaran HI',
          icon: Icons.directions_bus,
          pinColor: AppColors.accentOrange,
        ),
        MapMarkerItem(
          point: LatLng(-6.1753, 106.8271),
          title: 'Halte Monas',
          icon: Icons.directions_bus,
          pinColor: AppColors.primary,
        ),
        MapMarkerItem(
          point: LatLng(-6.1352, 106.8133),
          title: 'Halte Kota',
          icon: Icons.flag,
          pinColor: AppColors.errorRed,
        ),
      ];
}
