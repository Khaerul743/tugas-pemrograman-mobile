# 🏗️ Arsitektur & Struktur Folder Proyek Ecowalk

Dokumen ini menjelaskan rancangan arsitektur, struktur modular terbaru (*Feature-First*), prinsip desain perangkat lunak yang diterapkan, serta mekanisme navigasi utama aplikasi **Ecowalk**.

---

## 1. Latar Belakang & Reorganisasi Struktur

Awalnya, proyek ini menggunakan struktur direktori berbasis tipe (*Layer-First / Flat Structure*) di mana seluruh berkas diletakkan langsung di dalam folder `lib/pages/` dan `lib/widgets/`. Seiring pertumbuhan aplikasi dari 10 halaman awal hingga mencapai **35+ halaman dan puluhan komponen**, pendekatan datar tersebut menimbulkan beberapa kendala:
- **Tingkat keterikatan tinggi (*Tight Coupling*)**: Sangat sulit membedakan komponen yang khusus milik fitur tertentu dengan komponen yang dapat digunakan ulang (*reusable*).
- **Kesulitan skalabilitas**: Menjelang integrasi API eksternal (BMKG, transit, database destinasi, auth server), penambahan lapisan data (*Repository, Remote Data Source, DTO*) akan menyebabkan folder menjadi terlalu padat dan rentan konflik kode.
- **Navigasi kode yang lambat**: Pengembang harus menyusuri puluhan berkas yang bercampur tanpa konteks domain yang jelas.

Oleh karena itu, proyek telah dimigrasi sepenuhnya ke **Feature-First Architecture** dengan menerapkan prinsip **Separation of Concerns (SoC)**.

---

## 2. Diagram Pohon Direktori (`lib/`)

```text
lib/
├── main.dart                                   # Titik masuk aplikasi & konfigurasi rute terpusat
│
├── assets/                                     # Aset gambar, ikon SVG, dan ilustrasi lokal
│   └── images/
│       ├── thumbnail/                          # Thumbnail destinasi & konten rekomendasi
│       ├── google_logo.svg                     # Logo autentikasi sosial
│       ├── runner_green.svg                    # Maskot/ilustrasi mobilitas hijau
│       ├── icon_chatbot.png                    # Ikon asisten virtual Ecowalk
│       └── ...
│
├── core/                                       # Inti sistem aplikasi (global, agnostik fitur)
│   ├── constants/
│   │   ├── api_constants.dart                  # Base URL, endpoint, & timeout jaringan
│   │   └── app_colors.dart                     # Palet warna resmi terpusat (#1A6556 dll.)
│   └── network/
│       └── api_client.dart                     # Abstraksi BaseApiClient & template HTTP Client
│
├── features/                                   # Domain fitur terisolasi (Feature-First)
│   ├── auth/                                   # 🔐 Modul Autentikasi & Akun
│   │   └── presentation/
│   │       ├── widgets/                        # Komponen khusus autentikasi (ForpassTemplate, OtpTemplate)
│   │       ├── login_page.dart
│   │       ├── register_page.dart
│   │       ├── email_otp_page.dart
│   │       ├── no_hp_otp_page.dart
│   │       ├── forpass_email_page.dart
│   │       ├── forpass_no_hp_page.dart
│   │       ├── change_pass_page.dart
│   │       ├── change_phone_page.dart
│   │       ├── change_email_page.dart
│   │       ├── update_password_page.dart
│   │       ├── verify_phone_update_page.dart
│   │       └── verify_email_update_page.dart
│   │
│   ├── home/                                   # 🏠 Modul Beranda & Penjelajahan Wisata
│   │   └── presentation/
│   │       ├── home_page.dart                  # Layar utama dashboard & eksplorasi
│   │       ├── destination_detail_page.dart    # Detail objek wisata, galeri, & ulasan
│   │       ├── category_detail_page.dart       # Katalog destinasi per kategori
│   │       ├── ratings_reviews_page.dart       # Daftar ulasan lengkap pengguna
│   │       ├── add_review_page.dart            # Form penulisan ulasan dan rating
│   │       └── recently_viewed_page.dart       # Riwayat destinasi yang baru dikunjungi
│   │
│   ├── recommendation/                         # 🚌 Modul Rekomendasi Rute & Transit Berkelanjutan
│   │   └── presentation/
│   │       ├── recommendation_page.dart        # Form pencarian rute & tempat populer
│   │       ├── route_recommendation_page.dart  # Hasil rute (Cepat, Rendah Emisi, Pejalan Kaki)
│   │       ├── vehicle_analysis_page.dart      # Analisis perbandingan publik vs pribadi (CO2)
│   │       ├── public_transport_detail_page.dart # Panduan armada publik (Transjakarta, KRL, dll.)
│   │       ├── departure_schedule_page.dart    # Jadwal kedatangan dan keberangkatan armada
│   │       └── trip_recap_page.dart            # Rangkuman penghematan emisi & jarak tempuh
│   │
│   ├── weather/                                # 🌦️ Modul Cuaca & Kualitas Udara
│   │   └── presentation/
│   │       └── weather_detail_page.dart        # Rincian prakiraan cuaca, UV index, & AQI
│   │
│   ├── profile/                                # 👤 Modul Profil & Preferensi Pengguna
│   │   └── presentation/
│   │       ├── widgets/                        # PhotoSourceSheet, ProfileAvatarPicker, SettingsItem
│   │       ├── profile_page.dart               # Tampilan profil utama pengguna
│   │       ├── edit_profile_page.dart          # Form perubahan nama & foto profil
│   │       ├── camera_page.dart                # Antarmuka kamera kustom pengambilan foto
│   │       └── settings_page.dart              # Pengaturan akun, ganti kredensial, & privasi
│   │
│   ├── notifications/                          # 🔔 Modul Notifikasi
│   │   └── presentation/
│   │       └── notifications_page.dart         # Riwayat pemberitahuan promo, cuaca, & rute
│   │
│   └── static_pages/                           # 📄 Modul Halaman Informasi Statis
│       └── presentation/
│           ├── splash_page.dart                # Splash screen pembuka
│           ├── about_us_page.dart              # Informasi tim pengembang & visi Ecowalk
│           ├── privacy_policy_page.dart        # Kebijakan privasi data pengguna
│           ├── terms_of_service_page.dart      # Syarat dan ketentuan penggunaan aplikasi
│           └── empty_placeholder_page.dart     # Halaman penampung status kosong
│
└── shared/                                     # Komponen global yang dibagikan antar fitur
    └── widgets/
        ├── dialogs/                            # Dialog konfirmasi (Logout, Hapus Akun)
        │   ├── logout_dialog.dart
        │   └── delete_account_dialog.dart
        ├── custom_bottom_navigation.dart       # Bilah navigasi bawah dengan animasi sliding indicator
        ├── main_navigation_wrapper.dart        # Shell container navigasi tab utama
        ├── header_clipper.dart                 # Clipper lekukan header melengkung
        ├── logo.dart                           # Komponen visual logo Ecowalk
        └── rounded_input_field.dart            # Input teks rounded yang dapat digunakan kembali
```

---

## 3. Penjelasan Lapisan Arsitektur

### A. Lapisan `core/` (Pusat Fondasi)
Folder ini menyimpan logika dasar, utilitas, konstanta, dan infrastruktur komunikasi data yang bersifat global dan tidak terikat pada satu fitur tertentu:
1. **`constants/app_colors.dart`**: Menyediakan sumber warna tunggal (*single source of truth*) untuk warna brand `#1A6556` (Deep Teal), aksen, warna peringatan, hingga warna netral.
2. **`constants/api_constants.dart`**: Mengelola konfigurasi jaringan, base URL, path endpoint, dan konfigurasi *timeout*.
3. **`network/api_client.dart`**: Menyediakan kontrak abstrak `BaseApiClient` dan kelas `ApiClient` berbasis HTTP client. Hal ini memungkinkan penggantian implementasi komunikasi jaringan (misalnya dari paket `http` ke `dio`) tanpa memodifikasi kode pemanggil di lapisan fitur.

### B. Lapisan `features/` (Modular Domain-Driven)
Setiap folder di dalam `features/` mewakili sebuah modul bisnis atau domain aplikasi. Struktur di dalam setiap fitur dirancang untuk mendukung pemisahan sub-layer:
- **`presentation/`**: Berisi seluruh antarmuka pengguna (`Widget`, `Page`, `State`) yang berinteraksi langsung dengan pengguna.
- **`domain/`** *(siap diimplementasikan)*: Berisi entitas murni (*Entity*), *Use Cases*, dan antarmuka *Repository*.
- **`data/`** *(siap diimplementasikan)*: Berisi model data DTO (*Data Transfer Object*), *Data Sources* (Local/Remote), dan implementasi *Repository*.

Dengan pemisahan ini, seorang developer dapat mengembangkan modul `recommendation` tanpa khawatir merusak modul `auth` atau `weather`.

### C. Lapisan `shared/` (Komponen Bersama)
Komponen atau widget yang digunakan oleh dua atau lebih domain fitur diletakkan di `shared/`. Ini mencegah duplikasi kode (*Don't Repeat Yourself - DRY*). Contoh:
- Dialog konfirmasi keluar dan hapus akun.
- Komponen input teks standar (`RoundedInputField`).
- Widget ornamen visual (`HeaderClipper`, `Logo`).

---

## 4. Pola Navigasi Shell (*Main Navigation Wrapper*)

Salah satu pembaruan arsitektur penting pada proyek ini adalah transisi dari navigasi halaman terpisah (*standalone pushReplacement*) menjadi **Shell Navigation Pattern** melalui [main_navigation_wrapper.dart](file:///c:/Users/Pongo/Documents/projects/flutter/tugas_pemrograman_mobile/tugas_1/lib/shared/widgets/main_navigation_wrapper.dart):

```
       ┌────────────────────────────────────────────────────────┐
       │                MainNavigationWrapper                   │
       ├────────────────────────────────────────────────────────┤
       │                                                        │
       │                   PageView / Shell Body                │
       │     ┌──────────────────┬──────────────┬───────────┐    │
       │     │  0: HomePage     │ 1: RecomPage │ 3: Profile│    │
       │     └──────────────────┴──────────────┴───────────┘    │
       │                                                        │
       ├────────────────────────────────────────────────────────┤
       │               CustomBottomNavigation                   │
       │  [Beranda (0)]  [Rekomendasi (1)]  [Chat (2)]  [Akun (3)]│
       │        ▲                                               │
       │        └── Sliding Indicator & Scale Morphing Icon     │
       └────────────────────────────────────────────────────────┘
```

### Keunggulan Mekanisme Ini:
1. **Performa & State Retention**: Pergantian antara Beranda, Rekomendasi, dan Profil tidak menghancurkan (*dispose*) halaman, sehingga posisi scroll, filter kategori yang dipilih, dan formulir pencarian tetap tersimpan.
2. **Animasi Transisi Halus**: Perpindahan tab dilengkapi animasi transisi geser terkontrol (`Curves.easeInOutCubic` berdurasi 320ms) yang terasa alami bagi pengguna.
3. **Indikator Geser Dinamis (*Sliding Floating Indicator*)**: Pada [custom_bottom_navigation.dart](file:///c:/Users/Pongo/Documents/projects/flutter/tugas_pemrograman_mobile/tugas_1/lib/shared/widgets/custom_bottom_navigation.dart), tombol aktif mengambang putih bergerak secara mulus di atas bilah hijau dengan interpolasi posisi berdasarkan slot indeks tab yang dipilih.
4. **Modal Asisten Virtual Terintegrasi**: Menekan ikon slot 2 (Chatbot) langsung menampilkan modal bottom sheet *Ecowalk Assistant* tanpa meninggalkan halaman yang sedang aktif.

---

## 5. Standar Kode & Konvensi Penamaan

Untuk menjamin konsistensi di seluruh repositori:
1. **Nama Berkas**: Menggunakan format `lower_snake_case.dart` (contoh: `forpass_no_hp_page.dart`, `route_recommendation_page.dart`).
2. **Nama Kelas**: Menggunakan format `PascalCase` (contoh: `MainNavigationWrapper`, `VehicleAnalysisPage`).
3. **Variabel & Metode**: Menggunakan format `camelCase` (contoh: `_currentSlotIndex`, `_handleEditProfile()`).
4. **Konstanta**: Menggunakan format `lowerCamelCase` dengan awalan kata penjelas atau `SCREAMING_SNAKE_CASE` jika berupa nilai konstan global.
5. **Linting Rules**: Terintegrasi penuh dengan `analysis_options.yaml` dari Flutter standard, menghasilkan **0 issue warnings/errors**.
