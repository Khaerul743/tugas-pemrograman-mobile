import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryDetailPage extends StatefulWidget {
  final String? initialCategory;

  const CategoryDetailPage({super.key, this.initialCategory});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  final TextEditingController _searchController = TextEditingController();
  late String _selectedCategory;

  // Filter states
  String _selectedDistanceOption = '500 M';
  double _distanceSliderValue = 15.0;
  String? _selectedQuickPrice;
  String? _selectedPopularLocation;
  String? _selectedZone;

  // Sort state
  String _selectedSort = 'Direkomendasikan';

  final List<String> _categories = [
    'Semua',
    'Kuliner',
    'Sejarah',
    'Alam',
    'Religi',
    'Seni',
  ];

  final List<Map<String, dynamic>> _allDestinations = [
    {
      'title': 'Dunia Fantasi (DUFAN)',
      'rating': 4.75,
      'hours': 'Open 10:00 - 22:00',
      'location': 'Ancol, Jakarta utara',
      'priceText': 'Mulai dari Rp. 200.000',
      'priceValue': 200000,
      'category': 'Semua',
      'zone': 'Luar Ruangan',
      'image': 'lib/assets/images/thumbnail_content.png',
    },
    {
      'title': 'Dunia Fantasi (DUFAN)',
      'rating': 4.75,
      'hours': 'Open 10:00 - 22:00',
      'location': 'Ancol, Jakarta utara',
      'priceText': 'Mulai dari Rp. 200.000',
      'priceValue': 200000,
      'category': 'Semua',
      'zone': 'Luar Ruangan',
      'image': 'lib/assets/images/thumbnail_content.png',
    },
    {
      'title': 'Dunia Fantasi (DUFAN)',
      'rating': 4.75,
      'hours': 'Open 10:00 - 22:00',
      'location': 'Ancol, Jakarta utara',
      'priceText': 'Mulai dari Rp. 200.000',
      'priceValue': 200000,
      'category': 'Semua',
      'zone': 'Luar Ruangan',
      'image': 'lib/assets/images/thumbnail_content.png',
    },
    {
      'title': 'Dunia Fantasi (DUFAN)',
      'rating': 4.75,
      'hours': 'Open 10:00 - 22:00',
      'location': 'Ancol, Jakarta utara',
      'priceText': 'Mulai dari Rp. 200.000',
      'priceValue': 200000,
      'category': 'Semua',
      'zone': 'Luar Ruangan',
      'image': 'lib/assets/images/thumbnail_content.png',
    },
    {
      'title': 'Dunia Fantasi (DUFAN)',
      'rating': 4.75,
      'hours': 'Open 10:00 - 22:00',
      'location': 'Ancol, Jakarta utara',
      'priceText': 'Mulai dari Rp. 200.000',
      'priceValue': 200000,
      'category': 'Semua',
      'zone': 'Luar Ruangan',
      'image': 'lib/assets/images/thumbnail_content.png',
    },
    {
      'title': 'Dunia Fantasi (DUFAN)',
      'rating': 4.75,
      'hours': 'Open 10:00 - 22:00',
      'location': 'Ancol, Jakarta utara',
      'priceText': 'Mulai dari Rp. 200.000',
      'priceValue': 200000,
      'category': 'Semua',
      'zone': 'Luar Ruangan',
      'image': 'lib/assets/images/thumbnail_content.png',
    },
    {
      'title': 'Dunia Fantasi (DUFAN)',
      'rating': 4.75,
      'hours': 'Open 10:00 - 22:00',
      'location': 'Ancol, Jakarta utara',
      'priceText': 'Mulai dari Rp. 200.000',
      'priceValue': 200000,
      'category': 'Semua',
      'zone': 'Luar Ruangan',
      'image': 'lib/assets/images/thumbnail_content.png',
    },
    {
      'title': 'Taman Mini Indonesia Indah',
      'rating': 4.65,
      'hours': 'Open 06:00 - 20:00',
      'location': 'Jakarta Timur',
      'priceText': 'Mulai dari Rp. 25.000',
      'priceValue': 25000,
      'category': 'Sejarah',
      'zone': 'Luar Ruangan',
      'image': 'lib/assets/images/thumbnail_content_2.png',
    },
    {
      'title': 'Wisata Kuliner Pasar Santa',
      'rating': 4.55,
      'hours': 'Open 10:00 - 21:00',
      'location': 'Kebayoran Baru, Jakarta Selatan',
      'priceText': 'Mulai dari Rp. 20.000',
      'priceValue': 20000,
      'category': 'Kuliner',
      'zone': 'Dalam Ruangan',
      'image': 'lib/assets/images/thumbnail_content.png',
    },
    {
      'title': 'Tebet Eco Park',
      'rating': 4.80,
      'hours': 'Open 06:00 - 19:00',
      'location': 'Tebet, Jakarta Selatan',
      'priceText': 'Gratis',
      'priceValue': 0,
      'category': 'Alam',
      'zone': 'Luar Ruangan',
      'image': 'lib/assets/images/thumbnail_content.png',
    },
    {
      'title': 'Masjid Istiqlal',
      'rating': 4.90,
      'hours': 'Open 04:00 - 21:00',
      'location': 'Sawah Besar, Jakarta Pusat',
      'priceText': 'Gratis',
      'priceValue': 0,
      'category': 'Religi',
      'zone': 'Dalam Ruangan',
      'image': 'lib/assets/images/thumbnail_content_2.png',
    },
    {
      'title': 'Galeri Nasional Indonesia',
      'rating': 4.70,
      'hours': 'Open 09:00 - 19:00',
      'location': 'Gambir, Jakarta Pusat',
      'priceText': 'Gratis',
      'priceValue': 0,
      'category': 'Seni',
      'zone': 'Dalam Ruangan',
      'image': 'lib/assets/images/thumbnail_content.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory ?? 'Semua';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['category'] != null && widget.initialCategory == null) {
      final cat = args['category'] as String;
      if (_categories.contains(cat)) {
        setState(() {
          _selectedCategory = cat;
        });
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredDestinations() {
    return _allDestinations.where((item) {
      // 1. Category tab filter
      if (_selectedCategory != 'Semua' && item['category'] != _selectedCategory) {
        return false;
      }

      // 2. Search query filter
      final query = _searchController.text.trim().toLowerCase();
      if (query.isNotEmpty) {
        final title = item['title'].toString().toLowerCase();
        final loc = item['location'].toString().toLowerCase();
        if (!title.contains(query) && !loc.contains(query)) {
          return false;
        }
      }

      // 3. Quick price filter
      if (_selectedQuickPrice != null) {
        final priceVal = item['priceValue'] as int;
        if (_selectedQuickPrice == 'Gratis' && priceVal != 0) {
          return false;
        }
        if (_selectedQuickPrice == '< Rp 50.000,00' && priceVal >= 50000) {
          return false;
        }
        if (_selectedQuickPrice == '< Rp 100.000,00' && priceVal >= 100000) {
          return false;
        }
        if (_selectedQuickPrice == '< Rp 300.000,00' && priceVal >= 300000) {
          return false;
        }
      }

      // 4. Zone filter
      if (_selectedZone != null && item['zone'] != _selectedZone) {
        return false;
      }

      return true;
    }).toList();
  }

  void _showFilterModal() {
    String modalDistanceOption = _selectedDistanceOption;
    double modalDistanceSlider = _distanceSliderValue;
    String? modalQuickPrice = _selectedQuickPrice;
    String? modalPopularLocation = _selectedPopularLocation;
    String? modalZone = _selectedZone;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.88,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  // Drag Handle
                  Center(
                    child: Container(
                      width: 48,
                      height: 5,
                      margin: const EdgeInsets.only(top: 10, bottom: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setModalState(() {
                                  modalDistanceOption = '500 M';
                                  modalDistanceSlider = 15.0;
                                  modalQuickPrice = null;
                                  modalPopularLocation = null;
                                  modalZone = null;
                                });
                              },
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                  color: Color(0xFF3880EC),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.close,
                                size: 22,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Scrollable Filter Body
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Rentang Jarak
                          const Text(
                            'Rentang Jarak',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildDistanceButton(
                                label: '500 M',
                                isSelected: modalDistanceOption == '500 M',
                                onTap: () => setModalState(() => modalDistanceOption = '500 M'),
                              ),
                              const SizedBox(width: 8),
                              _buildDistanceButton(
                                label: 'Terdekat',
                                isSelected: modalDistanceOption == 'Terdekat',
                                onTap: () => setModalState(() => modalDistanceOption = 'Terdekat'),
                              ),
                              const SizedBox(width: 8),
                              _buildDistanceButton(
                                label: 'Terjauh',
                                isSelected: modalDistanceOption == 'Terjauh',
                                onTap: () => setModalState(() => modalDistanceOption = 'Terjauh'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: const Color(0xFF1A6556),
                              inactiveTrackColor: Colors.grey.shade300,
                              thumbColor: const Color(0xFF1A6556),
                              overlayColor: const Color(0x291A6556),
                              trackHeight: 2.5,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                            ),
                            child: Slider(
                              value: modalDistanceSlider,
                              min: 0,
                              max: 100,
                              onChanged: (val) {
                                setModalState(() {
                                  modalDistanceSlider = val;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Terdekat',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Terjauh',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // 2. Rentang Harga
                          const Text(
                            'Rentang Harga',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A6556),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Minimal',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Rp 100.000,00',
                                        style: TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A6556),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Maksimal',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Rp 99.999.999,00',
                                        style: TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Quick Price 2x2 Pills
                          Row(
                            children: [
                              Expanded(
                                child: _buildPricePill(
                                  label: '< Rp 50.000,00',
                                  isSelected: modalQuickPrice == '< Rp 50.000,00',
                                  onTap: () {
                                    setModalState(() {
                                      modalQuickPrice = (modalQuickPrice == '< Rp 50.000,00') ? null : '< Rp 50.000,00';
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildPricePill(
                                  label: '< Rp 100.000,00',
                                  isSelected: modalQuickPrice == '< Rp 100.000,00',
                                  onTap: () {
                                    setModalState(() {
                                      modalQuickPrice = (modalQuickPrice == '< Rp 100.000,00') ? null : '< Rp 100.000,00';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _buildPricePill(
                                  label: '< Rp 300.000,00',
                                  isSelected: modalQuickPrice == '< Rp 300.000,00',
                                  onTap: () {
                                    setModalState(() {
                                      modalQuickPrice = (modalQuickPrice == '< Rp 300.000,00') ? null : '< Rp 300.000,00';
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildPricePill(
                                  label: 'Gratis',
                                  isSelected: modalQuickPrice == 'Gratis',
                                  onTap: () {
                                    setModalState(() {
                                      modalQuickPrice = (modalQuickPrice == 'Gratis') ? null : 'Gratis';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          const Divider(height: 32, thickness: 1, color: Color(0xFFEEEEEE)),

                          // 3. Lokasi Populer
                          const Text(
                            'Lokasi Populer',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...['Blok M', 'Gelora Bung Karno', 'Senayan', 'Citra Delapan'].map((loc) {
                            final isSelected = modalPopularLocation == loc;
                            return InkWell(
                              onTap: () {
                                setModalState(() {
                                  modalPopularLocation = isSelected ? null : loc;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      loc,
                                      style: const TextStyle(
                                        fontSize: 13.5,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected ? const Color(0xFF1A6556) : const Color(0xFF5E9E90),
                                          width: 1.6,
                                        ),
                                        color: isSelected ? const Color(0xFF1A6556) : Colors.transparent,
                                      ),
                                      child: isSelected
                                          ? const Icon(Icons.check, size: 12, color: Colors.white)
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),

                          const SizedBox(height: 20),

                          // 4. Zona
                          const Text(
                            'Zona',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildZoneBox(
                                label: 'Dalam Ruangan',
                                isSelected: modalZone == 'Dalam Ruangan',
                                icon: CustomIndoorIcon(
                                  size: 24,
                                  color: modalZone == 'Dalam Ruangan' ? const Color(0xFF1A6556) : Colors.black87,
                                ),
                                onTap: () {
                                  setModalState(() {
                                    modalZone = (modalZone == 'Dalam Ruangan') ? null : 'Dalam Ruangan';
                                  });
                                },
                              ),
                              const SizedBox(width: 14),
                              _buildZoneBox(
                                label: 'Luar Ruangan',
                                isSelected: modalZone == 'Luar Ruangan',
                                icon: Icon(
                                  Icons.sports_soccer,
                                  size: 24,
                                  color: modalZone == 'Luar Ruangan' ? const Color(0xFF1A6556) : Colors.black87,
                                ),
                                onTap: () {
                                  setModalState(() {
                                    modalZone = (modalZone == 'Luar Ruangan') ? null : 'Luar Ruangan';
                                  });
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 28),

                          // Terapkan button
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedDistanceOption = modalDistanceOption;
                                  _distanceSliderValue = modalDistanceSlider;
                                  _selectedQuickPrice = modalQuickPrice;
                                  _selectedPopularLocation = modalPopularLocation;
                                  _selectedZone = modalZone;
                                });
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1A6556),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Terapkan Filter',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSortModal() {
    String modalSort = _selectedSort;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.only(bottom: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag Handle
                  Center(
                    child: Container(
                      width: 48,
                      height: 5,
                      margin: const EdgeInsets.only(top: 10, bottom: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Urutkan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.close,
                            size: 22,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Sort Options
                  ...[
                    'Direkomendasikan',
                    'Harga Tertinggi',
                    'Harga Terendah',
                    'Ulasan Terbaik',
                    'Jarak Terdekat',
                  ].map((option) {
                    final isSelected = modalSort == option;
                    return InkWell(
                      onTap: () {
                        setModalState(() {
                          modalSort = option;
                        });
                        setState(() {
                          _selectedSort = option;
                        });
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              option,
                              style: const TextStyle(
                                fontSize: 14.5,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? const Color(0xFF1A6556) : const Color(0xFF5E9E90),
                                  width: 1.6,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF1A6556),
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDistanceButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1A6556),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildPricePill({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF1A6556) : const Color(0xFF333333),
            width: 1.2,
          ),
          color: isSelected ? const Color(0x141A6556) : Colors.transparent,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? const Color(0xFF1A6556) : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildZoneBox({
    required String label,
    required bool isSelected,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? const Color(0xFF1A6556) : Colors.grey.shade400,
            width: isSelected ? 1.8 : 1,
          ),
          color: isSelected ? const Color(0x0F1A6556) : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? const Color(0xFF1A6556) : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredDestinations = _getFilteredDestinations();

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
            'Kategori',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          titleSpacing: 0,
        ),
        body: Column(
          children: [
            // Search Bar & Action Buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  // Search Field
                  Expanded(
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey.shade300, width: 1.2),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) => setState(() {}),
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(fontSize: 13.5, color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: 'Cari destinasi wisata',
                          hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // Filter Button
                  GestureDetector(
                    onTap: _showFilterModal,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.tune,
                          size: 20,
                          color: Color(0xFF1A6556),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF1A6556),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 14),

                  // Urutkan Button
                  GestureDetector(
                    onTap: _showSortModal,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SortAscendingIcon(
                          color: Color(0xFF1A6556),
                          size: 20,
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Urutkan',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF1A6556),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),

            // Horizontal Categories Tab Bar
            SizedBox(
              height: 40,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _categories.length,
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
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? const Color(0xFF1A6556) : Colors.transparent,
                            width: 2.2,
                          ),
                        ),
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.black : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

            // Destinations List
            Expanded(
              child: filteredDestinations.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          Text(
                            'Tidak ada destinasi ditemukan',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredDestinations.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFF0F0F0),
                      ),
                      itemBuilder: (context, index) {
                        final item = filteredDestinations[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/detailDestination',
                              arguments: {
                                'title': item['title'],
                                'location': item['location'],
                                'price': item['priceText'],
                                'imagePath': item['image'] ?? 'lib/assets/images/detail_image_thumbnail.png',
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                // Circular Placeholder
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFD9D9D9),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 14),

                                // Destination Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 3),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xFFFFC107),
                                            size: 13,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            '${item['rating']} ',
                                            style: const TextStyle(
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            '| ${item['hours']}',
                                            style: TextStyle(
                                              fontSize: 11.5,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item['location'],
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          color: Colors.grey.shade600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item['priceText'],
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // Trailing Chevron
                                const Icon(
                                  Icons.chevron_right,
                                  color: Colors.black87,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for Indoor Icon (House with wavy lines)
class CustomIndoorIcon extends StatelessWidget {
  final double size;
  final Color color;

  const CustomIndoorIcon({
    super.key,
    this.size = 24,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _IndoorIconPainter(color: color),
      ),
    );
  }
}

class _IndoorIconPainter extends CustomPainter {
  final Color color;
  const _IndoorIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // House outline
    final path = Path();
    path.moveTo(w * 0.22, h * 0.45);
    path.lineTo(w * 0.5, h * 0.18);
    path.lineTo(w * 0.78, h * 0.45);
    path.lineTo(w * 0.78, h * 0.85);
    path.lineTo(w * 0.22, h * 0.85);
    path.close();
    canvas.drawPath(path, paint);

    // 2 small wave lines inside
    final wavePaint = Paint()
      ..color = color
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (double yOffset in [h * 0.54, h * 0.69]) {
      final wave = Path();
      wave.moveTo(w * 0.36, yOffset);
      wave.quadraticBezierTo(w * 0.43, yOffset - 2, w * 0.5, yOffset);
      wave.quadraticBezierTo(w * 0.57, yOffset + 2, w * 0.64, yOffset);
      canvas.drawPath(wave, wavePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _IndoorIconPainter oldDelegate) => oldDelegate.color != color;
}

// Custom Sort Ascending Icon (Arrow up on left, stacked lines on right)
class SortAscendingIcon extends StatelessWidget {
  final Color color;
  final double size;

  const SortAscendingIcon({
    super.key,
    required this.color,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _SortAscendingPainter(color: color),
      ),
    );
  }
}

class _SortAscendingPainter extends CustomPainter {
  final Color color;
  const _SortAscendingPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // Upward arrow on left
    canvas.drawLine(Offset(w * 0.25, h * 0.85), Offset(w * 0.25, h * 0.15), paint);
    canvas.drawLine(Offset(w * 0.10, h * 0.35), Offset(w * 0.25, h * 0.15), paint);
    canvas.drawLine(Offset(w * 0.40, h * 0.35), Offset(w * 0.25, h * 0.15), paint);

    // 3 horizontal bars on right
    canvas.drawLine(Offset(w * 0.58, h * 0.25), Offset(w * 0.95, h * 0.25), paint);
    canvas.drawLine(Offset(w * 0.58, h * 0.52), Offset(w * 0.85, h * 0.52), paint);
    canvas.drawLine(Offset(w * 0.58, h * 0.80), Offset(w * 0.75, h * 0.80), paint);
  }

  @override
  bool shouldRepaint(covariant _SortAscendingPainter oldDelegate) => oldDelegate.color != color;
}
