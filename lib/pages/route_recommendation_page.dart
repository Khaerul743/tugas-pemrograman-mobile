import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RouteRecommendationPage extends StatefulWidget {
  final String? origin;
  final String? destination;

  const RouteRecommendationPage({
    super.key,
    this.origin,
    this.destination,
  });

  @override
  State<RouteRecommendationPage> createState() => _RouteRecommendationPageState();
}

class _RouteRecommendationPageState extends State<RouteRecommendationPage> {
  // Category selection: 'Transportasi Umum' or 'Pribadi'
  String _selectedCategory = 'Transportasi Umum';

  // Selected vehicle item
  String? _selectedVehicleId;

  // Selected travel mode pill
  int _selectedModeIndex = 0;

  final List<Map<String, dynamic>> _travelModes = [
    {'icon': Icons.directions_walk, 'time': '13 menit'},
    {'icon': Icons.directions_car, 'time': '5 menit'},
    {'icon': Icons.two_wheeler, 'time': '4 menit'},
    {'icon': Icons.directions_bus, 'time': '18 menit'},
  ];

  final List<Map<String, dynamic>> _publicTransports = [
    {
      'id': 'transjakarta',
      'title': 'Transjakarta',
      'tags': 'Bus, BRT, JakLingko',
      'desc': 'Murah, nyaman, jalur khusus',
      'time': '18 menit',
      'price': 'Rp 3.500',
      'image': 'lib/assets/images/thumbnail-transjakarta.jpg',
    },
    {
      'id': 'krl',
      'title': 'KRL Commuter',
      'tags': 'Bus, KRL, MRT, LRT',
      'desc': 'Hemat, dan murah',
      'time': '14 menit',
      'price': 'Rp 3.000',
      'image': 'lib/assets/images/thumbnail-krl.jpg',
    },
    {
      'id': 'mrt_lrt',
      'title': 'MRT / LRT',
      'tags': 'Kereta Cepat Terpadu',
      'desc': 'Cepat, tepat waktu',
      'time': '12 menit',
      'price': 'Rp 10.000',
      'image': 'lib/assets/images/thumbnail-krl.jpg',
    },
  ];

  final List<Map<String, dynamic>> _privateTransports = [
    {
      'id': 'ojek_online',
      'title': 'Ojek Online',
      'tags': 'Gojek, Grab, Maxim',
      'desc': 'Nyaman, dan cepat',
      'time': '4 menit',
      'price': 'Rp 14.000',
      'image': 'lib/assets/images/thumbnail-ojek-online.png',
    },
    {
      'id': 'taxi',
      'title': 'Taxi',
      'tags': 'Blue Bird, GrabCar, GoCar',
      'desc': 'Efisien, dan nyaman',
      'time': '5 menit',
      'price': 'Rp 35.000',
      'image': 'lib/assets/images/thumbnail-taxi.jpg',
    },
    {
      'id': 'kendaraan_pribadi',
      'title': 'Kendaraan Pribadi',
      'tags': 'Mobil / Motor Pribadi',
      'desc': 'Fleksibel & bebas rute',
      'time': '5 menit',
      'price': 'Bensin Mandiri',
      'image': 'lib/assets/images/thumbnail-ojek-online.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final displayOrigin = widget.origin ?? args?['origin'] ?? 'KLAPANUNGGAL';
    final displayDestination = widget.destination ?? args?['destination'] ?? 'Trans Studio Cibubur';

    final currentVehicleList =
        _selectedCategory == 'Transportasi Umum' ? _publicTransports : _privateTransports;

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
              const SizedBox(height: 16),

              // 1. Origin & Destination Route Card (Green Box)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A6556),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1F000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Origin & Destination Indicators (Dot + Dashed Line + Pin)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(height: 3),
                          CustomPaint(
                            size: const Size(2, 22),
                            painter: _DashedLinePainter(),
                          ),
                          const SizedBox(height: 3),
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),

                      const SizedBox(width: 14),

                      // Text Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Titik Awal',
                              style: TextStyle(
                                fontSize: 9.5,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              displayOrigin,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Divider(
                              height: 1,
                              thickness: 0.8,
                              color: Colors.white54,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Titik Akhir',
                              style: TextStyle(
                                fontSize: 9.5,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              displayDestination,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // 2. Ecowalk Logo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset(
                  'lib/assets/images/full_logo.png',
                  height: 26,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 14),

              // 3. Travel Mode Time Pills
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(_travelModes.length, (index) {
                    final mode = _travelModes[index];
                    final isSelected = _selectedModeIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedModeIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFE8F2EF) : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF1A6556) : Colors.grey.shade300,
                            width: isSelected ? 1.4 : 1,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0A000000),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              mode['icon'] as IconData,
                              size: 16,
                              color: isSelected ? const Color(0xFF1A6556) : Colors.black87,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              mode['time'] as String,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? const Color(0xFF1A6556) : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 16),

              // 4. Route Map Template
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 145,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      'lib/assets/images/map_template.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 5. Section "Opsi Kendaraan" Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Opsi Kendaraan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 5b. Flow: Selection of Category (Transportasi Umum vs Pribadi)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Tab 1: Transportasi Umum
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = 'Transportasi Umum';
                            _selectedVehicleId = null;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                            color: _selectedCategory == 'Transportasi Umum'
                                ? const Color(0xFF1A6556)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF1A6556),
                              width: 1.4,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0F000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.directions_bus,
                                size: 16,
                                color: _selectedCategory == 'Transportasi Umum'
                                    ? Colors.white
                                    : const Color(0xFF1A6556),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Transportasi Umum',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedCategory == 'Transportasi Umum'
                                      ? Colors.white
                                      : const Color(0xFF1A6556),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Tab 2: Pribadi
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = 'Pribadi';
                            _selectedVehicleId = null;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                            color: _selectedCategory == 'Pribadi'
                                ? const Color(0xFF1A6556)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF1A6556),
                              width: 1.4,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0F000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.two_wheeler,
                                size: 16,
                                color: _selectedCategory == 'Pribadi'
                                    ? Colors.white
                                    : const Color(0xFF1A6556),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Pribadi',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedCategory == 'Pribadi'
                                      ? Colors.white
                                      : const Color(0xFF1A6556),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // 5c. Vehicle Cards Carousel (Filtered by selected category)
              SizedBox(
                height: 130,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: currentVehicleList.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final vehicle = currentVehicleList[index];
                    final isSelected = _selectedVehicleId == vehicle['id'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedVehicleId = vehicle['id'];
                        });
                        // Navigate to Trip Recap or confirmation
                        _showTripSummaryModal(
                          vehicle: vehicle,
                          origin: displayOrigin,
                          destination: displayDestination,
                        );
                      },
                      child: Container(
                        width: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected
                              ? Border.all(color: const Color(0xFF1A6556), width: 2.2)
                              : null,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(isSelected ? 10 : 12),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Background Vehicle Image
                              Image.asset(
                                vehicle['image'] as String,
                                fit: BoxFit.cover,
                              ),

                              // Bottom Gradient & Labels
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Color(0xFA000000),
                                        Color(0xA6000000),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        vehicle['title'] as String,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 1),
                                      Text(
                                        vehicle['tags'] as String,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 6.5,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        vehicle['desc'] as String,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 6.5,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Selected Checkmark Badge
                              if (isSelected)
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF1A6556),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // 6. Recommendation Tips Card (Green Box with 👉)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A6556),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1F000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTipRow(
                        question: 'Mau cepat & murah?',
                        recommendation: 'Ojek Online',
                        onTap: () {
                          setState(() {
                            _selectedCategory = 'Pribadi';
                            _selectedVehicleId = 'ojek_online';
                          });
                          Navigator.pushNamed(
                            context,
                            '/vehicleAnalysis',
                            arguments: {
                              'vehicleType': 'ojek_online',
                              'title': 'OJEK ONLINE',
                              'badge': 'Tercepat',
                              'price': 'Rp. 30.000 - 45.000',
                              'duration': '20 Menit',
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildTipRow(
                        question: 'Mau murah banget?',
                        recommendation: 'Kendaraan Umum',
                        onTap: () {
                          setState(() {
                            _selectedCategory = 'Transportasi Umum';
                            _selectedVehicleId = 'krl';
                          });
                          Navigator.pushNamed(
                            context,
                            '/vehicleAnalysis',
                            arguments: {
                              'vehicleType': 'transportasi_umum',
                              'title': 'TRANSPORTASI UMUM',
                              'badge': 'Termurah',
                              'price': 'Rp. 0 - 20.000',
                              'duration': '1 Jam 45 Menit',
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildTipRow(
                        question: 'Mau nyaman & santai?',
                        recommendation: 'Taksi',
                        onTap: () {
                          setState(() {
                            _selectedCategory = 'Pribadi';
                            _selectedVehicleId = 'taxi';
                          });
                          Navigator.pushNamed(
                            context,
                            '/vehicleAnalysis',
                            arguments: {
                              'vehicleType': 'taxi',
                              'title': 'TAXI',
                              'badge': 'Nyaman',
                              'price': 'Rp. 50.000 - 80.000',
                              'duration': '35 Menit',
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipRow({
    required String question,
    required String recommendation,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            question,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            '👉',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(width: 6),
          Text(
            recommendation,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showTripSummaryModal({
    required Map<String, dynamic> vehicle,
    required String origin,
    required String destination,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Rute dengan ${vehicle['title']}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Perkiraan Waktu:',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                  Text(
                    vehicle['time'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF1A6556),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Perkiraan Tarif:',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                  Text(
                    vehicle['price'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF1A6556),
                    ),
                  ),
                ],
              ),
              // Button: Lihat Analisis Perjalanan
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    final isPublic = _selectedCategory == 'Transportasi Umum';
                    Navigator.pushNamed(
                      context,
                      '/vehicleAnalysis',
                      arguments: {
                        'vehicleType': isPublic ? 'transportasi_umum' : vehicle['id'],
                        'title': vehicle['title'].toString().toUpperCase(),
                        'badge': isPublic ? 'Termurah' : 'Tercepat',
                        'price': vehicle['price'],
                        'duration': vehicle['time'],
                      },
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1A6556),
                    side: const BorderSide(color: Color(0xFF1A6556), width: 1.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Lihat Analisis Perjalanan',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      '/tripRecap',
                      arguments: {
                        'title': destination,
                        'date': 'Hari Ini | Sekarang',
                        'address': destination,
                        'imagePath': 'lib/assets/images/detail_image_thumbnail.png',
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A6556),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Pilih Rute Ini',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

// Custom Painter for Vertical Dashed Line
class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    const dashHeight = 3.0;
    const dashSpace = 3.0;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, (startY + dashHeight).clamp(0, size.height)),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
