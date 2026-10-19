import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas_1/widgets/logo.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1A6556),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A6556),
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Tentang Kami',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ECOWAK Logo at top-right
              const Align(
                alignment: Alignment.topRight,
                child: LogoWidget(height: 18),
              ),
              const SizedBox(height: 16),

              // Paragraph 1
              const Text(
                'ECOWALK adalah aplikasi wisata yang membantu pengguna menemukan destinasi terbaik dengan rekomendasi berdasarkan lokasi, perbandingan harga, serta informasi transportasi.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),

              // Misi Kami (Underlined)
              const Text(
                'Misi Kami',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Menyediakan pengalaman wisata yang lebih mudah, informatif, dan terjangkau bagi semua orang dengan fokus pada ekowisata yang ramah lingkungan.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),

              // Apa yang Kami Tawarkan?
              const Text(
                'Apa yang Kami Tawarkan?',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              _buildBulletItem('Rekomendasi tempat wisata berdasarkan lokasi dan preferensi Anda.'),
              _buildBulletItem('Informasi harga tiket, ketersediaan fasilitas, dan ulasan pengguna.'),
              _buildBulletItem('Peta interaktif untuk membantu navigasi di area wisata.'),
              _buildBulletItem('Perbandingan harga transportasi untuk perjalanan yang lebih hemat.'),
              const SizedBox(height: 20),

              // Closing statement
              const Text(
                'Kami percaya bahwa menjelajahi dunia harus menjadi pengalaman yang menyenangkan dan mudah diakses oleh semua orang, dengan tetap menjaga kelestarian lingkungan.\n\nUntuk pertanyaan atau saran, hubungi kami di:',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 16),

              // Contact Email
              Row(
                children: const [
                  Icon(Icons.mail, size: 20, color: Colors.black87),
                  SizedBox(width: 12),
                  Text(
                    'support@ecowalk.com',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Contact Phone
              Row(
                children: const [
                  Icon(Icons.phone, size: 20, color: Colors.black87),
                  SizedBox(width: 12),
                  Text(
                    '0899-1234-4567',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
