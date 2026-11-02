import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RatingsReviewsPage extends StatefulWidget {
  final String? destinationName;

  const RatingsReviewsPage({
    super.key,
    this.destinationName,
  });

  @override
  State<RatingsReviewsPage> createState() => _RatingsReviewsPageState();
}

class _RatingsReviewsPageState extends State<RatingsReviewsPage> {
  String _selectedFilter = 'Semua';
  int? _selectedStar;

  final List<Map<String, dynamic>> _allReviews = [
    {
      'name': 'Kaisyarani Zahra',
      'rating': '5.0 / 5.0',
      'stars': 5,
      'text':
          'pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik',
      'date': 'Ditulis pada 12 Februari 2025',
      'photos': <String>[],
    },
    {
      'name': 'Kaisyarani Zahra',
      'rating': '5.0 / 5.0',
      'stars': 5,
      'text':
          'pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik',
      'date': 'Ditulis pada 12 Februari 2025',
      'photos': ['photo1', 'photo2'],
    },
    {
      'name': 'Kaisyarani Zahra',
      'rating': '5.0 / 5.0',
      'stars': 5,
      'text':
          'pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik',
      'date': 'Ditulis pada 12 Februari 2025',
      'photos': <String>[],
    },
    {
      'name': 'Kaisyarani Zahra',
      'rating': '5.0 / 5.0',
      'stars': 5,
      'text':
          'pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik',
      'date': 'Ditulis pada 12 Februari 2025',
      'photos': <String>[],
    },
    {
      'name': 'Kaisyarani Zahra',
      'rating': '5.0 / 5.0',
      'stars': 5,
      'text':
          'pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik pokoknya sngat bagus makcik',
      'date': 'Ditulis pada 12 Februari 2025',
      'photos': ['photo1', 'photo2'],
    },
  ];

  List<Map<String, dynamic>> get _filteredReviews {
    return _allReviews.where((review) {
      if (_selectedFilter == 'Dengan Foto' && (review['photos'] as List).isEmpty) {
        return false;
      }
      if (_selectedStar != null && review['stars'] != _selectedStar) {
        return false;
      }
      return true;
    }).toList();
  }

  void _showStarFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Berdasarkan Bintang',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                title: const Text('Semua Bintang'),
                trailing: _selectedStar == null ? const Icon(Icons.check, color: Color(0xFF1A6556)) : null,
                onTap: () {
                  setState(() {
                    _selectedStar = null;
                    _selectedFilter = 'Semua';
                  });
                  Navigator.pop(context);
                },
              ),
              ...List.generate(5, (index) {
                final starCount = 5 - index;
                return ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      starCount,
                      (i) => const Icon(Icons.star, color: Color(0xFFFFC107), size: 18),
                    ),
                  ),
                  title: Text('$starCount Bintang'),
                  trailing: _selectedStar == starCount ? const Icon(Icons.check, color: Color(0xFF1A6556)) : null,
                  onTap: () {
                    setState(() {
                      _selectedStar = starCount;
                      _selectedFilter = 'Bintang $starCount';
                    });
                    Navigator.pop(context);
                  },
                );
              }),
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
            'Nilai & Ulasan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color(0xFF1A6556),
          onPressed: () {
            Navigator.pushNamed(context, '/addReview');
          },
          icon: const Icon(Icons.edit, color: Colors.white, size: 18),
          label: const Text(
            'Tulis Ulasan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Summary
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: Rating + Stars + Count
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            '4.75',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: const [
                              Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                              Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                              Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                              Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                              Icon(Icons.star_half, color: Color(0xFFFFC107), size: 20),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      const Text.rich(
                        TextSpan(
                          text: '24.543 ',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Ulasan',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Right: ECOWAK Logo
                  Image.asset(
                    'lib/assets/images/full_logo.png',
                    height: 22,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            // Filter Pills Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _filterButton(
                    label: 'Semua',
                    isSelected: _selectedFilter == 'Semua',
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'Semua';
                        _selectedStar = null;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  _filterButton(
                    label: 'Dengan Foto',
                    isSelected: _selectedFilter == 'Dengan Foto',
                    onTap: () {
                      setState(() {
                        _selectedFilter = _selectedFilter == 'Dengan Foto' ? 'Semua' : 'Dengan Foto';
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  _filterButton(
                    label: _selectedStar != null ? 'Bintang $_selectedStar ∨' : 'Bintang ∨',
                    isSelected: _selectedStar != null,
                    onTap: _showStarFilterDialog,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // List of Review Cards
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 80),
                physics: const BouncingScrollPhysics(),
                itemCount: _filteredReviews.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final review = _filteredReviews[index];
                  return _buildReviewCard(review);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFF1A6556),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    final List<String> photos = (review['photos'] as List).cast<String>();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User header row
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  review['name'] ?? 'Kaisyarani Zahra',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A6556),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  review['rating'] ?? '5.0 / 5.0',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Review text
          Text(
            review['text'] ?? '',
            style: const TextStyle(
              fontSize: 10.5,
              color: Colors.black87,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 3),

          // Selengkapnya link
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Selengkapnya',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF02B8E0),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Attached photos (if any)
          if (photos.isNotEmpty) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                _buildPhotoThumbnail(),
                const SizedBox(width: 10),
                _buildPhotoThumbnail(),
              ],
            ),
          ],

          const SizedBox(height: 6),

          // Date at bottom right
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              review['date'] ?? 'Ditulis pada 12 Februari 2025',
              style: TextStyle(
                fontSize: 8.5,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoThumbnail() {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
