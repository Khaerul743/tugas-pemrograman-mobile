import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas_1/widgets/custom_bottom_navigation.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  final List<Map<String, dynamic>> _recommendations = [
    {
      'title': 'Moja Museum',
      'location': 'Jakarta Pusat',
      'price': 'Mulai dari Rp. 136.500',
      'rating': 4.5,
      'image': 'lib/assets/images/thumbnail/content_1.png',
    },
    {
      'title': 'Ocean Park BSD City Serpong',
      'location': 'Tangerang',
      'price': 'Mulai dari Rp. 65.000',
      'rating': 4.5,
      'image': 'lib/assets/images/thumbnail/content_2.png',
    },
    {
      'title': 'Kawasan Kota Tua',
      'location': 'Jakarta Barat',
      'price': 'Mulai dari Rp. 15.000',
      'rating': 4.5,
      'image': 'lib/assets/images/thumbnail_content.png',
    },
    {
      'title': 'Taman Mini Indonesia Indah',
      'location': 'Jakarta Timur',
      'price': 'Mulai dari Rp. 25.000',
      'rating': 4.7,
      'image': 'lib/assets/images/thumbnail_content_2.png',
    },
  ];

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _onSearchRoute() {
    final origin = _originController.text.trim();
    final dest = _destinationController.text.trim();
    Navigator.pushNamed(
      context,
      '/routeRecommendation',
      arguments: {
        'origin': origin.isNotEmpty ? origin : 'KLAPANUNGGAL',
        'destination': dest.isNotEmpty ? dest : 'Trans Studio Cibubur',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                // 1. Logo Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Image.asset(
                    'lib/assets/images/full_logo.png',
                    height: 28,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 22),

                // 2. Heading "MAU KEMANA HARI INI?"
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'MAU KEMANA HARI INI?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // 3. Search Route Card (Green Box with 2 Inputs)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
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
                    child: Column(
                      children: [
                        // Origin Location Input
                        Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TextField(
                            controller: _originController,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontSize: 13, color: Colors.black87),
                            decoration: InputDecoration(
                              hintText: 'Masukan Lokasi Asal',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey.shade600,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black87,
                                size: 22,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                              isDense: true,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Destination Location Input
                        Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TextField(
                            controller: _destinationController,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontSize: 13, color: Colors.black87),
                            decoration: InputDecoration(
                              hintText: 'Masukan Lokasi Tujuan',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey.shade600,
                              ),
                              prefixIcon: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.black87,
                                size: 22,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // 4. "Cari Rute" Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 38,
                    child: ElevatedButton(
                      onPressed: _onSearchRoute,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A6556),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Cari Rute',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // 5. Section "Rekomendasi Tujuan"
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Rekomendasi Tujuan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Horizontal Destination Cards
                SizedBox(
                  height: 270,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _recommendations.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 14),
                    itemBuilder: (context, index) {
                      final item = _recommendations[index];
                      return _buildDestinationCard(item);
                    },
                  ),
                ),

                const SizedBox(height: 110), // Space for bottom navigation
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigation(currentIndex: 1),
      ),
    );
  }

  Widget _buildDestinationCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detailDestination',
          arguments: {
            'title': item['title'],
            'location': item['location'],
            'price': item['price'],
            'imagePath': item['image'],
          },
        );
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.asset(
                item['image'] as String,
                fit: BoxFit.cover,
              ),

              // Bottom Gradient Overlay & Details
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xF0000000),
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
                        item['title'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.redAccent,
                            size: 11,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              item['location'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xD9FFFFFF),
                                fontSize: 9.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['price'] as String,
                        style: const TextStyle(
                          color: Color(0xD9FFFFFF),
                          fontSize: 9.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (i) => const Icon(
                                Icons.star,
                                color: Color(0xFFFFC107),
                                size: 12,
                              ),
                            ),
                          ),
                          const Text(
                            'Lebih Lanjut ›',
                            style: TextStyle(
                              color: Color(0xBFFFFFFF),
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
