import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddReviewPage extends StatefulWidget {
  final String? destinationName;
  final String? imagePath;

  const AddReviewPage({
    super.key,
    this.destinationName,
    this.imagePath,
  });

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  int _selectedRating = 5;
  bool _hideUsername = false;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 5:
        return 'Bagus';
      case 4:
        return 'Puas';
      case 3:
        return 'Cukup';
      case 2:
        return 'Kurang';
      case 1:
        return 'Buruk';
      default:
        return '';
    }
  }

  void _handleSubmit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ulasan berhasil dikirim! Terima kasih atas ulasanmu.'),
        backgroundColor: Color(0xFF1A6556),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final displayDestination = widget.destinationName ?? args?['destinationName'] ?? 'Dunia Fantasi\n(DUFAN)';
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
          title: const Text(
            'Beri Ulasan',
            style: TextStyle(
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
              // Top Thumbnail with rounded bottom corners and Destination badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
                    child: Image.asset(
                      displayImage,
                      width: double.infinity,
                      height: 185,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 18,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A6556),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1F000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        displayDestination,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting text
                    const Text(
                      'Hai, Kaisyarani !',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'bagaimana perjalananmu?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Star rating row
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            final isFilled = index < _selectedRating;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedRating = index + 1;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Icon(
                                  isFilled ? Icons.star : Icons.star_border,
                                  color: Colors.black87,
                                  size: 32,
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(width: 4),
                        if (_selectedRating > 0)
                          Text(
                            _getRatingLabel(_selectedRating),
                            style: const TextStyle(
                              color: Color(0xFF4CAF50),
                              fontWeight: FontWeight.w600,
                              fontSize: 12.5,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Review input field
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _reviewController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        style: const TextStyle(fontSize: 13, color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: 'Ketik disini . . .',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Tambahkan Gambar?
                    const Text(
                      'Tambahkan Gambar?',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        // Dotted / dashed add box
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black45,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 26,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Sample uploaded thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            'lib/assets/images/thumbnail_content.png',
                            width: 58,
                            height: 58,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Checkbox: Sembunyikan Nama Pengguna
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _hideUsername,
                            activeColor: const Color(0xFF1A6556),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _hideUsername = value ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Sembunyikan Nama Pengguna',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A6556),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Kirim',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
