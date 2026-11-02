import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas_1/widgets/custom_bottom_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'Semua';
  bool _showReviewCard = true;
  int _reviewRating = 0;

  final List<String> _categories = [
    'Semua',
    'Kuliner',
    'Sejarah',
    'Alam',
    'Religi',
    'Seni',
  ];

  void _showChatbotDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'lib/assets/images/icon_chatbot.png',
                width: 70,
                height: 70,
              ),
              const SizedBox(height: 12),
              const Text(
                'Ecowalk Assistant',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A6556),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Halo! Ada yang bisa saya bantu untuk merencanakan liburan serumu hari ini?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.5, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A6556),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Mulai Mengobrol', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
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
        body: Stack(
          children: [
            SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildTopHeader(),
                    const SizedBox(height: 16),
                    _buildWeatherCard(),
                    const SizedBox(height: 20),
                    _buildRekomendasiSection(),
                    const SizedBox(height: 16),
                    if (_showReviewCard) ...[
                      _buildReviewCard(),
                      const SizedBox(height: 16),
                    ],
                    _buildKategoriSection(),
                    const SizedBox(height: 18),
                    _buildPilihanTeratasSection(),
                    const SizedBox(height: 20),
                    _buildBannerBacaPeta(),
                    const SizedBox(height: 20),
                    _buildKunjungiLagiSection(),
                    const SizedBox(height: 20),
                    _buildTerakhirDilihatSection(),
                    const SizedBox(height: 100), // Space for bottom navigation
                  ],
                ),
              ),
            ),

            // Floating Chatbot Icon on Bottom Right
            Positioned(
              right: 14,
              bottom: 86,
              child: GestureDetector(
                onTap: _showChatbotDialog,
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1F000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'lib/assets/images/icon_chatbot.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavigation(currentIndex: 0),
      ),
    );
  }

  // 1. Top Header: Logo + Avatar + Notification
  Widget _buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Image.asset(
            'lib/assets/images/full_logo.png',
            height: 32,
            fit: BoxFit.contain,
          ),

          // User Avatar + Notification Bell
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/profile'),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/kucing.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/notifications'),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1A6556),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2. Weather Card
  Widget _buildWeatherCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/weatherDetail'),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF165F50),
                Color(0xFF3B7467),
                Color(0xFF6F998F),
                Color(0xFFBACBC6),
              ],
              stops: [0.0, 0.32, 0.65, 1.0],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F000000),
                blurRadius: 10,
                offset: Offset(0, 4), 
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Minggu, 16 Febuari 2025',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Klapanunggal, Bogor',
                      style: TextStyle(
                        color: Color(0xF2FFFFFF),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '30°C',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Cerah Berawan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Right weather icon
              Image.asset(
                'lib/assets/images/icon awan.png',
                width: 146,
                height: 114,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 3. Rekomendasi Section (Vertical Cards)
  Widget _buildRekomendasiSection() {
    final items = [
      {
        'title': 'Dunia Fantasi (DUFAN)',
        'location': 'Ancol, Jakarta Utara',
        'price': 'Rp. 200.000',
        'distance': '1.50 KM',
        'image': 'lib/assets/images/thumbnail_content.png',
      },
      {
        'title': 'Taman Mini Indonesia Indah (TMII)',
        'location': 'Jakarta Timur',
        'price': 'Mulai dari Rp. 25.000',
        'distance': '3.80 KM',
        'image': 'lib/assets/images/thumbnail_content_2.png',
      },
      {
        'title': 'Taman Impian Jaya Ancol',
        'location': 'Jakarta Utara',
        'price': 'Mulai dari Rp. 30.000',
        'distance': '2.10 KM',
        'image': 'lib/assets/images/thumbnail_content.png',
      },
      {
        'title': 'Taman Safari Indonesia',
        'location': 'Cisarua, Bogor',
        'price': 'Mulai dari Rp. 180.000',
        'distance': '18.5 KM',
        'image': 'lib/assets/images/thumbnail_content_2.png',
      },
      {
        'title': 'Kebun Raya Bogor',
        'location': 'Kota Bogor',
        'price': 'Mulai dari Rp. 15.000',
        'distance': '12.2 KM',
        'image': 'lib/assets/images/thumbnail_content.png',
      },
      {
        'title': 'Pantai Indah Kapuk (PIK)',
        'location': 'Jakarta Utara',
        'price': 'Gratis Masuk',
        'distance': '8.40 KM',
        'image': 'lib/assets/images/thumbnail_content_2.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Rekomendasi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 240,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildVerticalDestinationCard(
                title: item['title']!,
                location: item['location']!,
                price: item['price']!,
                distance: item['distance']!,
                imagePath: item['image']!,
              );
            },
          ),
        ),
      ],
    );
  }

  // Card widget for Rekomendasi and Terakhir Dilihat
  Widget _buildVerticalDestinationCard({
    required String title,
    required String location,
    required String price,
    required String distance,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detailDestination',
          arguments: {
            'title': title,
            'location': location,
            'price': price,
            'imagePath': 'lib/assets/images/detail_image_thumbnail.png',
          },
        );
      },
      child: Container(
        width: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),

            // Top Right Distance Badge
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xD91A6556),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  distance,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Bottom Gradient Overlay & Details
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xEB000000),
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
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                          size: 10,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xD9FFFFFF),
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      price,
                      style: const TextStyle(
                        color: Color(0xD9FFFFFF),
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (i) => const Icon(
                              Icons.star,
                              color: Color(0xFFFFC107),
                              size: 11.5,
                            ),
                          ),
                        ),
                        const Text(
                          'Lebih Lanjut >',
                          style: TextStyle(
                            color: Color(0xBFFFFFFF),
                            fontSize: 8.5,
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

  // 4. Review Prompt Card (Dismissible with 'X')
  Widget _buildReviewCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bagaimana Perjalananmu?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _showReviewCard = false),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Yuk beri ulasan untuk tempat yang baru kamu kunjungi!',
              style: TextStyle(
                fontSize: 11.5,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) {
                final isSelected = index < _reviewRating;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _reviewRating = index + 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(
                      isSelected ? Icons.star : Icons.star_border,
                      color: isSelected ? const Color(0xFFFFC107) : Colors.black87,
                      size: 26,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // 5. Kategori Section (Filter Pills)
  Widget _buildKategoriSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/categoryDetail',
                    arguments: {'category': _selectedCategory},
                  );
                },
                child: Row(
                  children: const [
                    Text(
                      'Jelajahi',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right, size: 16, color: Colors.black87),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 36,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final isSelected = cat == _selectedCategory;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = cat;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF1A6556) : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    cat,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // 6. Pilihan Teratas Section (Wide Cards)
  Widget _buildPilihanTeratasSection() {
    final items = [
      {
        'title': 'Dunia Fantasi (DUFAN)',
        'location': 'Ancol, Jakarta Utara',
        'image': 'lib/assets/images/thumbnail_content.png',
      },
      {
        'title': 'Dunia Fantasi (DUFAN)',
        'location': 'Ancol, Jakarta Utara',
        'image': 'lib/assets/images/thumbnail_content.png',
      },
      {
        'title': 'Taman Mini Indonesia Indah',
        'location': 'Jakarta Timur',
        'image': 'lib/assets/images/thumbnail_content_2.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pilihan Teratas',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/categoryDetail',
                    arguments: {'category': _selectedCategory},
                  );
                },
                child: Row(
                  children: const [
                    Text(
                      'Jelajahi',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right, size: 16, color: Colors.black87),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildLandscapeDestinationCard(
                title: item['title']!,
                location: item['location']!,
                imagePath: item['image']!,
              );
            },
          ),
        ),
      ],
    );
  }

  // Card widget for Pilihan Teratas and Kunjungi Lagi
  Widget _buildLandscapeDestinationCard({
    required String title,
    required String location,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detailDestination',
          arguments: {
            'title': title,
            'location': location,
            'imagePath': 'lib/assets/images/detail_image_thumbnail.png',
          },
        );
      },
      child: Container(
        width: 165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xE6000000),
                      Color(0x8C000000),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                          size: 9,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xD9FFFFFF),
                              fontSize: 8.5,
                            ),
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

  // 7. Banner Promosi / Baca Peta
  Widget _buildBannerBacaPeta() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'lib/assets/images/icon_baca_peta.png',
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  // 8. Kunjungi Lagi Section
  Widget _buildKunjungiLagiSection() {
    final items = [
      {
        'title': 'Dunia Fantasi (DUFAN)',
        'location': 'Ancol, Jakarta Utara',
        'image': 'lib/assets/images/thumbnail_content.png',
      },
      {
        'title': 'Dunia Fantasi (DUFAN)',
        'location': 'Ancol, Jakarta Utara',
        'image': 'lib/assets/images/thumbnail_content.png',
      },
      {
        'title': 'Taman Mini Indonesia Indah',
        'location': 'Jakarta Timur',
        'image': 'lib/assets/images/thumbnail_content_2.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Kunjungi Lagi',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Selengkapnya',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 16, color: Colors.black87),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildLandscapeDestinationCard(
                title: item['title']!,
                location: item['location']!,
                imagePath: item['image']!,
              );
            },
          ),
        ),
      ],
    );
  }

  // 9. Terakhir Dilihat Section
  Widget _buildTerakhirDilihatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/recentlyViewed'),
                child: const Text(
                  'Terakhir Dilihat',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/recentlyViewed'),
                child: Row(
                  children: const [
                    Text(
                      'Selengkapnya',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right, size: 16, color: Colors.black87),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 240,
            child: _buildVerticalDestinationCard(
              title: 'Dunia Fantasi (DUFAN)',
              location: 'Ancol, Jakarta Utara',
              price: 'Rp. 200.000',
              distance: '1.50 KM',
              imagePath: 'lib/assets/images/thumbnail_content.png',
            ),
          ),
        ),
      ],
    );
  }
}
