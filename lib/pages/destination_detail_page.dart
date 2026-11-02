import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DestinationDetailPage extends StatefulWidget {
  final String? title;
  final String? imagePath;
  final String? location;
  final String? price;

  const DestinationDetailPage({
    super.key,
    this.title,
    this.imagePath,
    this.location,
    this.price,
  });

  @override
  State<DestinationDetailPage> createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final displayTitle = widget.title ?? args?['title'] ?? 'Dunia Fantasi (DUFAN)';
    final displayImage = widget.imagePath ?? args?['imagePath'] ?? 'lib/assets/images/detail_image_thumbnail.png';

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
          title: Text(
            displayTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Big Thumbnail with Rating Badge
              Stack(
                children: [
                  Image.asset(
                    displayImage,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 12,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xD91A6556),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.star, color: Color(0xFFFFC107), size: 14),
                          SizedBox(width: 4),
                          Text(
                            '4.75',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Floating Favorite Button Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            displayTitle,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_isFavorite
                                    ? 'Ditambahkan ke favorit!'
                                    : 'Dihapus dari favorit'),
                                duration: const Duration(seconds: 1),
                                backgroundColor: const Color(0xFF1A6556),
                              ),
                            );
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Color(0xFF1A6556),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: _isFavorite ? Colors.redAccent : Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Operating Hours & Open status
                    Row(
                      children: const [
                        Icon(Icons.access_time, size: 16, color: Colors.black87),
                        SizedBox(width: 6),
                        Text.rich(
                          TextSpan(
                            text: 'Open',
                            style: TextStyle(
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.bold,
                              fontSize: 12.5,
                            ),
                            children: [
                              TextSpan(
                                text: ' | 10:00 - 22:00',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Address / Location
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.menu_book_outlined, size: 16, color: Colors.black87),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Jl. Lodan Timur No.7, Ancol, Kec. Pademangan, Jkt Utara, Daerah Khusus Ibukota Jakarta 14430',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Description paragraph
                    const Text(
                      'Dufan (Dunia Fantasi) adalah taman hiburan yang terletak di kawasan Taman Impian Ancol, Jakarta Utara. Dufan merupakan salah satu taman hiburan terbesar dan terpopuler di Indonesia.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        height: 1.45,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Ticket Price
                    const Text(
                      'Harga Tiket Mulai Dari',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A6556),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Rp. 190.000 - Rp. 400.000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '*Harga tergantung hari dan dapat berubah sewaktu-waktu',
                      style: TextStyle(
                        fontSize: 9.5,
                        color: Colors.black45,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Section: Nilai & Ulasan
                    _buildNilaiDanUlasanSection(context),

                    const SizedBox(height: 22),

                    // Section: Lihat Peta
                    _buildLihatPetaSection(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNilaiDanUlasanSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nilai & Ulasan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),

        // Summary Rating Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A6556),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.star, color: Color(0xFFFFC107), size: 14),
                      SizedBox(width: 4),
                      Text(
                        '4.75',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Rekomendasi Istimewa',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '24.543 Ulasan',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/reviews');
              },
              child: Row(
                children: const [
                  Text(
                    'Lihat Semua',
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

        const SizedBox(height: 12),

        // Horizontal Review Cards
        SizedBox(
          height: 135,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildReviewItemCard(
                name: 'Kaisyarani Zahra',
                rating: '5.0 / 5.0',
                reviewText:
                    'pokoknya sangat bagus mantik pokoknya sangat bagus mantik pokoknya sangat bagus mantik pokoknya sangat bagus mantik pokoknya sangat bagus mantik pokoknya sangat bagus mantik',
                date: 'Ditulis pada 12 Februari 2025',
                showPhotos: false,
              ),
              const SizedBox(width: 12),
              _buildReviewItemCard(
                name: 'Kaisyarani Zahra',
                rating: '5.0 / 5.0',
                reviewText:
                    'pokoknya sangat bagus mantik pokoknya sangat bagus mantik pokoknya sangat bagus mantik pokoknya sangat bagus mantik',
                date: 'Ditulis pada 12 Februari 2025',
                showPhotos: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItemCard({
    required String name,
    required String rating,
    required String reviewText,
    required String date,
    required bool showPhotos,
  }) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A6556),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  rating,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              reviewText,
              maxLines: showPhotos ? 2 : 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 9.5,
                color: Colors.black87,
                height: 1.25,
              ),
            ),
          ),
          if (showPhotos) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                _photoThumbnail(),
                const SizedBox(width: 4),
                _photoThumbnail(),
                const SizedBox(width: 4),
                _photoThumbnail(),
              ],
            ),
          ],
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              date,
              style: const TextStyle(
                fontSize: 8.5,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Image.asset(
        'lib/assets/images/thumbnail_content.png',
        width: 24,
        height: 24,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLihatPetaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lihat Peta',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          '1.68 KM dari lokasimu saat ini',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'lib/assets/images/map_template.png',
            width: double.infinity,
            height: 175,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
