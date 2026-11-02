import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final type = widget.vehicleType ?? routeArgs?['vehicleType'] ?? 'ojek_online';
    final isPublicTransport = type == 'transportasi_umum';

    // Page configurations based on vehicle type
    final title = widget.title ??
        routeArgs?['title'] ??
        (isPublicTransport ? 'TRANSPORTASI UMUM' : 'OJEK ONLINE');

    final price = widget.price ??
        routeArgs?['price'] ??
        (isPublicTransport ? 'Rp. 0 - 20.000' : 'Rp. 30.000 - 45.000');

    final duration = widget.duration ??
        routeArgs?['duration'] ??
        (isPublicTransport ? '1 Jam 45 Menit' : '20 Menit');

    final badge = widget.badge ??
        routeArgs?['badge'] ??
        (isPublicTransport ? 'Termurah' : 'Tercepat');

    final heroImage = isPublicTransport
        ? 'lib/assets/images/thumbnail-krl.jpg'
        : 'lib/assets/images/thumbnail-ojek-online.png';

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
                    child: Image.asset(
                      heroImage,
                      fit: BoxFit.cover,
                    ),
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
                  height: 155,
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

              // 4. Analisis Perjalanan Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBFBFB),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200, width: 1.2),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 6,
                        offset: Offset(0, 2),
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

                      if (!isPublicTransport) ...[
                        // SECTION 1: Dibandingkan Naik Taxi
                        const Text(
                          'Dibandingkan Naik Taxi',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A6556),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildAnalysisRow('Waktu', '5 mnt Lebih cepat'),
                        const Divider(height: 16, thickness: 0.7),
                        _buildAnalysisRow('Hemat', 'Ojek Online'),
                        const Divider(height: 16, thickness: 0.7),
                        _buildAnalysisRow('Kenyamanan', 'Taxi'),

                        const SizedBox(height: 16),

                        // SECTION 2: Dibandingkan Kendaraan Umum
                        const Text(
                          'Dibandingkan Kendaraan Umum',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A6556),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildAnalysisRow('Waktu', '15 mnt Lebih lambat'),
                        const Divider(height: 16, thickness: 0.7),
                        _buildAnalysisRow('Hemat', 'Kendaraan Umum'),
                        const Divider(height: 16, thickness: 0.7),
                        _buildAnalysisRow('Kenyamanan', 'Taxi'),
                      ] else ...[
                        // SECTION 1: Dibandingkan Naik Ojek Online
                        const Text(
                          'Dibandingkan Naik Ojek Online',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A6556),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildAnalysisRow('Waktu', '30 mnt Lebih lambat'),
                        const Divider(height: 16, thickness: 0.7),
                        _buildAnalysisRow('Hemat', 'Kendaraan Umum'),
                        const Divider(height: 16, thickness: 0.7),
                        _buildAnalysisRow('Kenyamanan', 'Taxi'),

                        const SizedBox(height: 16),

                        // SECTION 2: Dibandingkan Taxi
                        const Text(
                          'Dibandingkan Taxi',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A6556),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildAnalysisRow('Waktu', '20-40 mnt Lebih cepat'),
                        const Divider(height: 16, thickness: 0.7),
                        _buildAnalysisRow('Hemat', 'Kendaraan Umum'),
                        const Divider(height: 16, thickness: 0.7),
                        _buildAnalysisRow('Kenyamanan', 'Taxi'),
                      ],
                    ],
                  ),
                ),
              ),

              // 5. Opsi Transportasi Umum (Only shown when vehicle is Transportasi Umum)
              if (isPublicTransport) ...[
                const SizedBox(height: 22),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Opsi Transportasi Umum',
                    style: TextStyle(
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
                      color: const Color(0xFFFBFBFB),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade200, width: 1.2),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildTransportOptionItem(
                          icon: Icons.directions_bus,
                          title: 'TransJakarta',
                          duration: '± 40 menit',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/publicTransportDetail',
                              arguments: {
                                'title': 'TRANSJAKARTA',
                                'badge': 'Rekomendasi',
                                'image': 'lib/assets/images/thumbnail-transjakarta.jpg',
                              },
                            );
                          },
                        ),
                        const Divider(height: 1, indent: 64, thickness: 0.6),
                        _buildTransportOptionItem(
                          icon: Icons.subway,
                          title: 'MRT Jakarta',
                          duration: '± 25 menit',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/publicTransportDetail',
                              arguments: {
                                'title': 'MRT JAKARTA',
                                'badge': 'Tercepat',
                                'image': 'lib/assets/images/thumbnail-krl.jpg',
                              },
                            );
                          },
                        ),
                        const Divider(height: 1, indent: 64, thickness: 0.6),
                        _buildTransportOptionItem(
                          icon: Icons.tram,
                          title: 'LRT Jabodetabek',
                          duration: '± 30 menit',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/publicTransportDetail',
                              arguments: {
                                'title': 'LRT JABODETABEK',
                                'badge': 'Nyaman',
                                'image': 'lib/assets/images/thumbnail-krl.jpg',
                              },
                            );
                          },
                        ),
                        const Divider(height: 1, indent: 64, thickness: 0.6),
                        _buildTransportOptionItem(
                          icon: Icons.train,
                          title: 'KRL Commuter Line',
                          duration: '± 35 menit',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/publicTransportDetail',
                              arguments: {
                                'title': 'KRL COMMUTER LINE',
                                'badge': 'Termurah',
                                'image': 'lib/assets/images/thumbnail-krl.jpg',
                              },
                            );
                          },
                        ),
                        const Divider(height: 1, indent: 64, thickness: 0.6),
                        _buildTransportOptionItem(
                          icon: Icons.airport_shuttle,
                          title: 'Mikrotrans (JakLingko)',
                          duration: '± 50 menit',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/publicTransportDetail',
                              arguments: {
                                'title': 'MIKROTRANS (JAKLINGKO)',
                                'badge': 'Gratis',
                                'image': 'lib/assets/images/thumbnail-transjakarta.jpg',
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],

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
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
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
                      color: Colors.black87,
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
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
