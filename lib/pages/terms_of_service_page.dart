import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas_1/widgets/logo.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

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
            'Ketentuan Layanan',
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
                'KETENTUAN PENGGUNAAN APLIKASI ECOWALK',
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
                'Selamat datang di ECOWALK! Dengan menggunakan aplikasi ini, Anda setuju dengan ketentuan dan persyaratan berikut:',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),

              // Section 1
              const Text(
                '1. Dengan menggunakan aplikasi ECOWALK, Anda dapat menemukan informasi tentang tempat wisata, rekomendasi tempat, perbandingan harga, dan layanan peta berbasis lokasi.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),

              // Section 2
              const Text(
                '2. Anda bertanggung jawab atas keakuratan data, termasuk ulasan dan foto, yang Anda masukkan.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),

              // Section 3
              const Text(
                '3. Perubahan Layanan ECOWALK berhak mengubah, menambah, atau menghentikan layanan tanpa pemberitahuan sebelumnya. Pengguna bertanggung jawab atas keamanan akun mereka, termasuk kata sandi. Pengguna juga dilarang menggunakan aplikasi untuk tujuan yang dapat merugikan pihak lain.\nInformasi yang diberikan oleh sumber seperti tiket atau biaya transportasi tidak akurat, dan kami tidak bertanggung jawab atas kesalahan tersebut.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),

              // Section 4
              const Text(
                '4. Penolakan Tanggung Jawab',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              _buildBulletItem('ECOWALK hanya menyediakan informasi sebagai referensi dan bukan penyedia layanan wisata atau transportasi.'),
              _buildBulletItem('Kami tidak bertanggung jawab atas perubahan harga, ketersediaan tempat, atau keterlambatan transportasi.'),
              const SizedBox(height: 22),

              // Closing
              const Text(
                'Dengan menggunakan aplikasi ini, Anda menyetujui semua ketentuan di atas.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.45,
                ),
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
