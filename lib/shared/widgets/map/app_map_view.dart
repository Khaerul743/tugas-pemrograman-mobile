import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tugas_1/core/constants/app_colors.dart';
import 'package:tugas_1/shared/widgets/map/map_models.dart';

/// Reusable interactive map component using OpenStreetMap tiles via flutter_map.
/// Supports single location preview, multiple markers, route polylines, and zoom controls.
class AppMapView extends StatefulWidget {
  final LatLng initialCenter;
  final double initialZoom;
  final List<MapMarkerItem> markers;
  final List<MapRouteData> routes;
  final bool interactive;
  final bool showControls;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final String? selectedMarkerTitle;
  final ValueChanged<MapMarkerItem>? onMarkerTap;

  const AppMapView({
    super.key,
    required this.initialCenter,
    this.initialZoom = 14.0,
    this.markers = const [],
    this.routes = const [],
    this.interactive = true,
    this.showControls = true,
    this.height,
    this.width,
    this.borderRadius,
    this.selectedMarkerTitle,
    this.onMarkerTap,
  });

  @override
  State<AppMapView> createState() => _AppMapViewState();
}

class _AppMapViewState extends State<AppMapView> {
  late final MapController _mapController;
  late double _currentZoom;
  late LatLng _currentCenter;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _currentZoom = widget.initialZoom;
    _currentCenter = widget.initialCenter;
  }

  @override
  void didUpdateWidget(covariant AppMapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialCenter != widget.initialCenter) {
      _currentCenter = widget.initialCenter;
      _mapController.move(_currentCenter, _currentZoom);
    }
  }

  void _zoomIn() {
    _currentZoom = (_currentZoom + 1).clamp(3.0, 18.0);
    _mapController.move(_mapController.camera.center, _currentZoom);
  }

  void _zoomOut() {
    _currentZoom = (_currentZoom - 1).clamp(3.0, 18.0);
    _mapController.move(_mapController.camera.center, _currentZoom);
  }

  void _recenter() {
    _currentZoom = widget.initialZoom;
    _mapController.move(widget.initialCenter, _currentZoom);
  }

  @override
  Widget build(BuildContext context) {
    final mapWidget = Stack(
      children: [
        // 1. Core FlutterMap
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: widget.initialCenter,
            initialZoom: widget.initialZoom,
            minZoom: 3.0,
            maxZoom: 18.0,
            interactionOptions: InteractionOptions(
              flags: widget.interactive ? InteractiveFlag.all : InteractiveFlag.none,
            ),
          ),
          children: [
            // OpenStreetMap Standard Tiles
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.tugas_1',
              maxZoom: 19,
            ),

            // Route Polylines
            if (widget.routes.isNotEmpty)
              PolylineLayer(
                polylines: widget.routes.map((route) {
                  return Polyline(
                    points: route.points,
                    color: route.color,
                    strokeWidth: route.strokeWidth,
                    strokeCap: StrokeCap.round,
                    strokeJoin: StrokeJoin.round,
                  );
                }).toList(),
              ),

            // Pin Markers
            if (widget.markers.isNotEmpty)
              MarkerLayer(
                markers: widget.markers.map((item) {
                  return Marker(
                    point: item.point,
                    width: 140,
                    height: 60,
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        if (item.onTap != null) {
                          item.onTap!();
                        } else if (widget.onMarkerTap != null) {
                          widget.onMarkerTap!(item);
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.showBadge)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x33000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          Icon(
                            item.icon,
                            color: item.pinColor,
                            size: 32,
                            shadows: const [
                              Shadow(
                                color: Color(0x33000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),

        // 2. Attribution Tag (OpenStreetMap Compliance)
        Positioned(
          left: 8,
          bottom: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xD9FFFFFF),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '© OpenStreetMap',
              style: TextStyle(
                fontSize: 9,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        // 3. Floating Map Controls (+, -, Recenter)
        if (widget.showControls && widget.interactive)
          Positioned(
            right: 10,
            bottom: 12,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildControlButton(
                  icon: Icons.my_location,
                  tooltip: 'Pusatkan Peta',
                  onPressed: _recenter,
                ),
                const SizedBox(height: 6),
                _buildControlButton(
                  icon: Icons.add,
                  tooltip: 'Perbesar',
                  onPressed: _zoomIn,
                ),
                const SizedBox(height: 4),
                _buildControlButton(
                  icon: Icons.remove,
                  tooltip: 'Perkecil',
                  onPressed: _zoomOut,
                ),
              ],
            ),
          ),
      ],
    );

    final rounded = ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(14),
      child: mapWidget,
    );

    if (widget.height != null || widget.width != null) {
      return SizedBox(
        height: widget.height,
        width: widget.width,
        child: rounded,
      );
    }

    return rounded;
  }

  Widget _buildControlButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.white,
      elevation: 3,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Tooltip(
          message: tooltip,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Icon(
              icon,
              size: 18,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
