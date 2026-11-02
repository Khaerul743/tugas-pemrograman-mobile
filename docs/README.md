# 🌿 Dokumentasi Resmi Proyek Ecowalk

Selamat datang di pusat dokumentasi resmi aplikasi mobile **Ecowalk**. Dokumen ini merangkum gambaran umum sistem, struktur arsitektur terbaru, rincian fungsionalitas dan fitur aplikasi, serta panduan teknis untuk pengembangan dan integrasi lanjutan.

---

## 📌 Sekilas Proyek

| Keterangan | Detail |
| :--- | :--- |
| **Nama Aplikasi** | **Ecowalk** |
| **Fokus & Visi** | Mobilitas Berkelanjutan (*Green Mobility*) & Pemandu Wisata Ramah Lingkungan (*Eco-Tourism Assistant*) |
| **Framework** | Flutter (Dart SDK `>=3.3.0 <4.0.0`) |
| **Arsitektur** | Feature-First (Modular Domain-Driven Structure) |
| **Target Platform** | Android, iOS, Web, Windows |
| **Kredensial Demo Masuk** | Username: `admin` \| Password: `12345678` |

---

## 🗺️ Indeks Dokumentasi

Untuk memudahkan pemahaman dan navigasi teknis, dokumentasi ini dipecah menjadi beberapa modul utama:

1. [**Arsitektur & Struktur Folder (`ARCHITECTURE.md`)**](file:///c:/Users/Pongo/Documents/projects/flutter/tugas_pemrograman_mobile/tugas_1/docs/ARCHITECTURE.md)
   - Latar belakang transisi dari struktur flat ke *Feature-First Architecture*.
   - Penerapan prinsip *Separation of Concerns (SoC)* dan *Clean Architecture*.
   - Pohon direktori komprehensif (`lib/core/`, `lib/features/`, `lib/shared/`).
   - Mekanisme navigasi shell (*Main Navigation Wrapper*) dengan transisi tab dinamis & bottom indicator animasi.

2. [**Rincian Fitur & Alur Pengguna (`FEATURES.md`)**](file:///c:/Users/Pongo/Documents/projects/flutter/tugas_pemrograman_mobile/tugas_1/docs/FEATURES.md)
   - Penjelasan mendalam mengenai 7 domain fitur utama:
     - 🔐 **Autentikasi & Akun** (Login, Register, Dual OTP, Forgot & Reset Password, Credential Updates).
     - 🏠 **Beranda & Eksplorasi Wisata** (Widget Cuaca, Rekomendasi Destinasi, Rating Wisata, Filter Kategori, Pilihan Teratas, Baca Peta).
     - 🚌 **Rute & Transit Ramah Lingkungan** (Rekomendasi Rute Realistis, Timeline Halte/Stasiun, Komparasi Kendaraan Publik vs Pribadi, Emisi CO2 & Biaya, Jadwal Keberangkatan).
     - 🌦️ **Prakiraan Cuaca Terintegrasi** (Hourly Forecast, Indeks UV, Kelembapan, Indeks Kualitas Udara / AQI).
     - 👤 **Profil Pengguna & Pengaturan** (Manajemen Profil, Avatar Kucing/Kamera/Galeri, Pengaturan Keamanan, Dialog Hapus Akun & Logout).
     - 💬 **Asisten Virtual Ecowalk & Notifikasi** (Chatbot Rekomendasi Cerdas & Pusat Notifikasi).
     - 📄 **Halaman Statis** (Splash Screen, Tentang Kami, Kebijakan Privasi, Syarat & Ketentuan).
   - Matriks 35 Rute Navigasi Lengkap.

3. [**Panduan Integrasi API Eksternal (`API_INTEGRATION_GUIDE.md`)**](file:///c:/Users/Pongo/Documents/projects/flutter/tugas_pemrograman_mobile/tugas_1/docs/API_INTEGRATION_GUIDE.md)
   - Desain fondasi network: `ApiClient`, `BaseApiClient`, dan `ApiConstants`.
   - Rancangan integrasi API: Weather API (BMKG/OpenWeather), Routing & Transit API, Tourism Places API, dan Backend Auth Service.
   - Pola Repository & Remote Data Source untuk pengembangan lanjutan.

---

## 🚀 Panduan Memulai (*Quick Start*)

### Prasyarat
- Flutter SDK (versi 3.19.0 atau yang lebih baru direkomendasikan).
- Android Studio / VS Code dengan ekstensi Flutter dan Dart terpasang.
- Emulator Android / iOS Simulator / Perangkat Fisik.

### Instalasi & Menjalankan Aplikasi
```bash
# 1. Kloning repositori (jika belum berada di workspace)
git clone https://github.com/Khaerul743/tugas-pemrograman-mobile.git

# 2. Masuk ke direktori tugas
cd tugas_1

# 3. Unduh seluruh dependensi paket
flutter pub get

# 4. Jalankan analisis kode (pastikan 0 warnings/errors)
flutter analyze

# 5. Jalankan unit & widget test
flutter test

# 6. Jalankan aplikasi pada perangkat aktif
flutter run
```

---

## 🎨 Palet Desain & Identitas Visual

Aplikasi Ecowalk mengusung identitas visual alam dan kenyamanan mobilitas dengan warna utama:
- **Ecowalk Deep Teal / Forest Green**: `#1A6556` (Identitas utama tema lingkungan & ketenangan).
- **Light Mint / Surface Tint**: `#E8F2EF` (Background aksen halus).
- **Warning / Star Amber**: `#FFC107` / `#FFA000` (Rating ulasan dan badge peringatan).
- **Alert / Accent Red**: `#E53935` (Pin lokasi dan aksi destruktif).
- **Clean White**: `#FFFFFF` (Surface kartu dan latar belakang konten).

Seluruh konstanta warna terpusat pada [`lib/core/constants/app_colors.dart`](file:///c:/Users/Pongo/Documents/projects/flutter/tugas_pemrograman_mobile/tugas_1/lib/core/constants/app_colors.dart).
