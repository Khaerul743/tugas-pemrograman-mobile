import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas_1/widgets/logo.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
            'Kebijakan Privasi',
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

              // Title Header
              const Text(
                'KEBIJAKAN PRIVASI APLIKASI ECOWALK',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Diperbaharui tanggal 16 Februari 2024',
                style: TextStyle(
                  fontSize: 11.5,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),

              // Introduction
              const Text(
                'Kami menghargai privasi pengguna. Kebijakan ini menjelaskan bagaimana ECOWALK mengumpulkan, menggunakan, dan melindungi data Anda.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),

              // Section 1
              const Text(
                '1. Data yang Kami Kumpulkan',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Kami dapat mengumpulkan data berikut:',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 6),
              _buildBulletItem('Data Pribadi: Nama, email, dan informasi akun.'),
              _buildBulletItem('Data Lokasi: Untuk memberikan rekomendasi wisata dan perhitungan jarak.'),
              _buildBulletItem('Ulasan dan Foto: Jika Anda memposting ulasan atau berbagi pengalaman wisata.'),
              const SizedBox(height: 20),

              // Section 2
              const Text(
                '2. Cara Kami Menggunakan Data',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              _buildBulletItem('Memberikan rekomendasi tempat wisata berdasarkan lokasi.'),
              _buildBulletItem('Memproses pencarian dan filter destinasi sesuai preferensi.'),
              _buildBulletItem('Menampilkan ulasan dan foto yang dibagikan pengguna lain.'),
              _buildBulletItem('Menyediakan informasi transportasi berdasarkan data lokasi.'),
              const SizedBox(height: 20),

              // Section 3
              const Text(
                '3. Keamanan Data',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Kami menggunakan enkripsi dan metode keamanan lainnya untuk melindungi data Anda.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),

              // Section 4
              const Text(
                '4. Hak Pengguna',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              _buildBulletItem('Anda dapat memperbarui atau menghapus informasi akun kapan saja.'),
              _buildBulletItem('Anda dapat menonaktifkan fitur lokasi jika tidak ingin berbagi data lokasi.'),
              _buildBulletItem('Kami tidak akan membagikan data pribadi Anda kepada pihak ketiga tanpa persetujuan Anda.'),
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
