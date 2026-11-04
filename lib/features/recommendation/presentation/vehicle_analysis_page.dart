import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:tugas_1/shared/widgets/map/map.dart';

class VehicleAnalysisPage extends StatefulWidget {
  final String? vehicleType; // 'ojek_online' | 'transportasi_umum' | 'taxi'
  final String? title;
  final String? price;
  final String? duration;
  final String? badge;

  const VehicleAnalysisPage({
    super.key,
    this.vehicleType,
    this.title,
    this.price,
    this.duration,
    this.badge,
  });

  @override
  State<VehicleAnalysisPage> createState() => _VehicleAnalysisPageState();
}

class _VehicleAnalysisPageState extends State<VehicleAnalysisPage> {
  static const _vehicleOptions = <Map<String, dynamic>>[
    {'id': 'transjakarta', 'type': 'transportasi_umum', 'title': 'TransJakarta', 'price': 'Rp 3.500', 'duration': '40 menit', 'badge': 'Rekomendasi', 'image': 'lib/assets/images/thumbnail-transjakarta.jpg', 'icon': Icons.directions_bus},
    {'id': 'mrt', 'type': 'transportasi_umum', 'title': 'MRT Jakarta', 'price': 'Rp 5.000 - 14.000', 'duration': '25 menit', 'badge': 'Tercepat', 'image': null, 'icon': Icons.subway},
    {'id': 'lrt', 'type': 'transportasi_umum', 'title': 'LRT Jabodetabek', 'price': 'Rp 5.000 - 20.000', 'duration': '30 menit', 'badge': 'Nyaman', 'image': null, 'icon': Icons.tram},
    {'id': 'krl', 'type': 'transportasi_umum', 'title': 'KRL Commuter Line', 'price': 'Rp 3.000 - 6.000', 'duration': '35 menit', 'badge': 'Termurah', 'image': 'lib/assets/images/thumbnail-krl.jpg', 'icon': Icons.train},
    {'id': 'mikrotrans', 'type': 'transportasi_umum', 'title': 'Mikrotrans (JakLingko)', 'price': 'Gratis', 'duration': '50 menit', 'badge': 'Gratis', 'image': null, 'icon': Icons.airport_shuttle},
    {'id': 'ojek_online', 'type': 'ojek_online', 'title': 'Ojek Online', 'price': 'Rp 14.000', 'duration': '4 menit', 'badge': 'Tercepat', 'image': 'lib/assets/images/thumbnail-ojek-online.png', 'icon': Icons.two_wheeler},
    {'id': 'taxi', 'type': 'taxi', 'title': 'Taxi', 'price': 'Rp 35.000', 'duration': '5 menit', 'badge': 'Nyaman', 'image': 'lib/assets/images/thumbnail-taxi.jpg', 'icon': Icons.local_taxi},
    {'id': 'kendaraan_pribadi', 'type': 'kendaraan_pribadi', 'title': 'Kendaraan Pribadi', 'price': 'Biaya bahan bakar', 'duration': '5 menit', 'badge': 'Fleksibel', 'image': null, 'icon': Icons.directions_car},
  ];

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final type = widget.vehicleType ?? routeArgs?['vehicleType'] ?? 'ojek_online';
    final isPublicTransport = type == 'transportasi_umum';
    Map<String, dynamic>? optionForType;
    for (final option in _vehicleOptions) {
      if (option['id'] == type) {
        optionForType = option;
        break;
      }
    }

    // Page configurations based on vehicle type
    final title = widget.title ??
        routeArgs?['title'] ??
        optionForType?['title'] ??
        (isPublicTransport ? 'TRANSPORTASI UMUM' : 'OJEK ONLINE');

    final price = widget.price ??
        routeArgs?['price'] ??
        optionForType?['price'] ??
        (isPublicTransport ? 'Rp. 0 - 20.000' : 'Rp. 30.000 - 45.000');

    final duration = widget.duration ??
        routeArgs?['duration'] ??
        optionForType?['duration'] ??
        (isPublicTransport ? '1 Jam 45 Menit' : '20 Menit');

    final badge = widget.badge ??
        routeArgs?['badge'] ??
        optionForType?['badge'] ??
        (isPublicTransport ? 'Termurah' : 'Tercepat');

    final normalizedTitle = title.toString().toLowerCase();
    final selectedOption = _vehicleOptions.cast<Map<String, dynamic>?>().firstWhere(
      (option) => option?['id'] == type ||
          (type == 'transportasi_umum' &&
              normalizedTitle != 'transportasi umum' &&
              ((option?['title'] as String? ?? '').toLowerCase().contains(normalizedTitle) ||
                  normalizedTitle.contains((option?['title'] as String? ?? '').toLowerCase()))),
      orElse: () => null,
    );
    final heroImage = routeArgs?['image'] as String? ??
        (selectedOption != null
            ? selectedOption['image'] as String?
            : type == 'taxi'
                ? 'lib/assets/images/thumbnail-taxi.jpg'
                : isPublicTransport
                    ? 'lib/assets/images/thumbnail-krl.jpg'
                    : 'lib/assets/images/thumbnail-ojek-online.png');
    final heroIcon = selectedOption?['icon'] as IconData? ?? Icons.directions_car;
    final comparisonOptions = _vehicleOptions.where((option) {
      if (selectedOption != null) return option['id'] != selectedOption['id'];
      if (isPublicTransport) return option['type'] != 'transportasi_umum';
      return true;
    }).toList();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A6556),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Rekomendasi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Hero Image with Floating Badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 205,
                    child: heroImage == null
                        ? Container(
                            color: const Color(0xFFE8F2EF),
                            child: Icon(heroIcon, size: 88, color: const Color(0xFF1A6556)),
                          )
                        : Image.asset(heroImage, fit: BoxFit.cover),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                          color: Color(0xFF1A6556),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // 2. Title & Details (Price + Duration)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Price Row
                    Row(
                      children: [
                        const Icon(
                          Icons.payments_outlined,
                          size: 18,
                          color: Colors.black87,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Duration Row
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 18,
                          color: Colors.black87,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          duration,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 3. Route Map Preview
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 185,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: AppMapView(
                    initialCenter: const LatLng(-6.1850, 106.8300),
                    initialZoom: 12.5,
                    borderRadius: BorderRadius.circular(14),
                    routes: [
                      MapRouteData(
                        points: MapData.mentengToDestinationRoute,
                        color: const Color(0xFF1A6556),
                        strokeWidth: 4.5,
                      ),
                    ],
                    markers: MapData.mentengMarkers,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 4. Analisis Perjalanan Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200, width: 1.2),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x18000000),
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Analisis Perjalanan',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 14),

                      ...comparisonOptions.map((option) {
                        final otherTitle = option['title'] as String;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dibandingkan $otherTitle',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A6556),
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildAnalysisRow('Waktu', option['duration'] as String),
                            const Divider(height: 16, thickness: 0.7),
                            _buildAnalysisRow('Biaya', option['price'] as String),
                            const Divider(height: 16, thickness: 0.7),
                            _buildAnalysisRow('Ciri', option['badge'] as String),
                            const SizedBox(height: 16),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),

              // Vehicle options for this analysis category.
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  isPublicTransport ? 'Opsi Transportasi Umum' : 'Opsi Kendaraan Pribadi',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200, width: 1.2),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x18000000),
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: _vehicleOptions
                        .where((option) => isPublicTransport
                            ? option['type'] == 'transportasi_umum'
                            : option['type'] != 'transportasi_umum')
                        .toList()
                        .asMap()
                        .entries
                        .map((entry) {
                      final option = entry.value;
                      return Column(
                        children: [
                          if (entry.key > 0)
                            const Divider(height: 1, indent: 64, thickness: 0.6),
                          _buildTransportOptionItem(
                            icon: option['icon'] as IconData,
                            title: option['title'] as String,
                            duration: '${option['duration']} | ${option['price']}',
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/publicTransportDetail',
                                arguments: {
                                  'title': (option['title'] as String).toUpperCase(),
                                  'badge': option['badge'],
                                  'image': option['image'],
                                  'details': option,
                                },
                              );
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTransportOptionItem({
    required IconData icon,
    required String title,
    required String duration,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            // Icon rounded container
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 20,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 14),

            // Title and Duration
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A6556),
                    ),
                  ),
                ],
              ),
            ),

            // "Detail" link
            GestureDetector(
              onTap: onTap,
              child: const Text(
                'Detail',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
