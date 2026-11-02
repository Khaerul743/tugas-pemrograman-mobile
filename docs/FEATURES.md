# 📱 Rincian Fitur & Alur Pengguna (*User Flow*) Ecowalk

Dokumen ini mendokumentasikan seluruh fungsionalitas, alur interaksi pengguna, parameter input, serta daftar 35 halaman antarmuka yang ada di dalam aplikasi **Ecowalk**.

---

## 1. Ikhtisar Domain Fitur

Aplikasi **Ecowalk** dirancang sebagai ekosistem terpadu antara pariwisata lokal dan mobilitas ramah lingkungan (*green mobility*). Aplikasi ini dibagi menjadi 7 domain bisnis utama:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        EKOSISTEM ECOWALK                               │
├─────────────────┬──────────────────┬─────────────────┬─────────────────┤
│  1. Autentikasi │  2. Beranda &    │ 3. Rekomendasi  │  4. Pemantauan  │
│     & Akun      │     Eksplorasi   │    Transit &    │     Cuaca       │
│                 │     Wisata       │    Emisi        │                 │
├─────────────────┼──────────────────┼─────────────────┼─────────────────┤
│  5. Profil &    │  6. Notifikasi & │ 7. Informasi    │ 8. Arsitektur   │
│     Keamanan    │     Asisten Bot  │    Hukum/Statis │    Shell Nav    │
└─────────────────┴──────────────────┴─────────────────┴─────────────────┘
```

---

## 2. Rincian Modul & Fitur

### 🔐 1. Modul Autentikasi & Akun (`features/auth`)

Menyediakan sistem pengamanan akses akun pengguna dengan alur verifikasi dua langkah (*two-step verification*) dan validasi sisi klien (*client-side validation*):

| Halaman | Rute | Deskripsi Fungsional & Validasi |
| :--- | :--- | :--- |
| **Masuk (Login)** | `/login` | - Input Nama Pengguna dan Kata Sandi.<br>- Validasi field tidak boleh kosong dan kata sandi minimal 6 karakter.<br>- **Kredensial Demo**: `admin` / `12345678`.<br>- Tombol social login dengan Google.<br>- Tautan menuju pendaftaran dan pemulihan kata sandi. |
| **Pendaftaran (Register)** | `/register` | - Input Nama Lengkap, Email, Nomor HP, Kata Sandi, dan Konfirmasi Kata Sandi.<br>- Validasi format email menggunakan *RegExp*.<br>- Validasi numerik nomor HP (minimal 10 digit).<br>- Validasi kesesuaian konfirmasi kata sandi.<br>- Wajib mencentang persetujuan Syarat & Ketentuan. |
| **Verifikasi OTP Nomor HP** | `/verificationWithNoHP` | - Input 4 digit kode OTP dengan auto-focus ke kotak berikutnya.<br>- Hitung mundur waktu kadaluarsa kode (*countdown timer*).<br>- Tautan opsi beralih verifikasi via Email. |
| **Verifikasi OTP Email** | `/verificationWithEmail` | - Input 4 digit kode verifikasi yang dikirimkan ke alamat email.<br>- Integrasi tombol kirim ulang kode dan alternatif via Nomor HP. |
| **Lupa Sandi (Nomor HP)** | `/forpassNoHp` | - Pemulihan akun melalui SMS/WhatsApp OTP.<br>- Validasi nomor HP terdaftar. |
| **Lupa Sandi (Email)** | `/forpassEmail` | - Pemulihan akun melalui tautan/kode email.<br>- Validasi pola alamat surel. |
| **Ubah Kata Sandi** | `/changePass` | - Input kata sandi baru dan konfirmasi kata sandi.<br>- Fitur *toggle obscure text* untuk menampilkan/menyembunyikan teks. |
| **Pembaruan Nomor HP** | `/changePhone` & `/verifyPhoneUpdate` | - Alur penggantian nomor telepon akun dari menu pengaturan profil yang diverifikasi melalui OTP nomor baru. |
| **Pembaruan Alamat Email** | `/changeEmail` & `/verifyEmailUpdate` | - Alur penggantian email akun dengan kode verifikasi OTP yang dikirim ke email baru. |
| **Ubah Sandi Pengaturan** | `/updatePassword` | - Pembaruan kata sandi dari dalam aplikasi dengan memasukkan kata sandi lama dan dua kali kata sandi baru. |

---

### 🏠 2. Modul Beranda & Penjelajahan Wisata (`features/home`)

Menjadi gerbang utama penjelajahan destinasi wisata berkelanjutan di area perkotaan:

| Halaman / Komponen | Rute | Fitur & Komponen Antarmuka |
| :--- | :--- | :--- |
| **Beranda (Home Page)** | `/home` | - **Header Pengguna**: Sambutan personal, indikator status, dan tombol lonceng notifikasi.<br>- **Widget Cuaca Ringkas**: Menampilkan suhu real-time (contoh: 27°C Berawan), ikon cuaca cerah/hujan, dan status kualitas udara.<br>- **Kartu Rekomendasi Unggulan**: Slider horizontal destinasi pilihan dengan badge jarak (km), harga tiket, dan rating bintang.<br>- **Review Prompt Card**: Kartu interaktif *"Bagaimana Perjalananmu?"* dengan rating bintang instan dan tombol dismiss (*X*).<br>- **Filter Kategori**: Filter cepat berupa pill tombol (*Semua, Kuliner, Sejarah, Alam, Religi, Seni*).<br>- **Pilihan Teratas & Kunjungi Lagi**: Galeri kartu lanskap tempat wisata favorit.<br>- **Banner Edukasi "Baca Peta"**: Banner interaktif panduan navigasi transit hijau.<br>- **Terakhir Dilihat**: Riwayat destinasi yang baru dibuka oleh pengguna. |
| **Detail Destinasi** | `/detailDestination` | - Foto utama beresolusi tinggi dengan hero image.<br>- Informasi alamat, jam operasional, tiket masuk, dan fasilitas hijau.<br>- Tab ringkasan fasilitas, tips ramah lingkungan, dan rating ulasan pengunjung.<br>- Tombol aksi langsung *"Kunjungi Sekarang"* menuju rekomendasi rute. |
| **Ulasan & Penilaian** | `/reviews` | - Daftar seluruh ulasan pengguna terverifikasi.<br>- Distribusi rating bintang dan komentar perjalanan. |
| **Tulis Ulasan** | `/addReview` | - Formulir penulisan feedback dan rating bintang (1 sampai 5).<br>- Unggah foto dokumentasi perjalanan. |
| **Katalog Kategori** | `/categoryDetail` | - Daftar seluruh objek wisata berdasarkan kategori yang dipilih dari beranda. |
| **Terakhir Dilihat** | `/recentlyViewed` | - Riwayat lengkap tempat yang sebelumnya dijelajahi pengguna. |

---

### 🚌 3. Modul Rekomendasi Rute & Transit Berkelanjutan (`features/recommendation`)

Merupakan fitur inti dari visi *Ecowalk* untuk mendorong mobilitas rendah emisi:

| Halaman | Rute | Fitur & Komponen Antarmuka |
| :--- | :--- | :--- |
| **Halaman Rekomendasi** | `/recommendation` | - **Formulir Rute**: Kolom input titik asal (*Titik Keberangkatan*) dan destinasi tujuan (*Tujuan Wisata*).<br>- **Tempat Populer**: Daftar rekomendasi destinasi ramah lingkungan (Moja Museum, Ocean Park BSD, Kawasan Kota Tua, Taman Mini, Ragunan Zoo) lengkap dengan estimasi biaya dan rating.<br>- Tombol pemicu pencarian rute cerdas. |
| **Rekomendasi Rute** | `/routeRecommendation` | - **Peta Navigasi Interaktif**: Tampilan rute visual berbasis ilustrasi peta kota.<br>- **Pilihan Tab Rute Cerdas**: Pilihan rute *Terkecil Emisi* (Transportasi Publik), *Tercepat*, dan *Ramah Pejalan Kaki*.<br>- **Timeline Transit Realistis**: Langkah demi langkah perpindahan halte/stasiun (contoh: Transjakarta Koridor 1, Stasiun KRL Manggarai, MRT Bundaran HI) lengkap dengan estimasi waktu tunggu.<br>- Tombol akses langsung menuju **Analisis Kendaraan**. |
| **Analisis Kendaraan** | `/vehicleAnalysis` | - **Pilihan Kategori Kendaraan**: Pemisahan tegas antara **Transportasi Umum** (Transjakarta, KRL Commuter Line, MRT, LRT) dan **Kendaraan Pribadi** (Sepeda Motor, Mobil Pribadi, Ojek Online).<br>- **Metrik Komparasi Lingkungan**: Perbandingan jejak emisi karbon (kg CO₂), estimasi biaya perjalanan (Rp), dan durasi waktu tempuh.<br>- Rekomendasi kendaraan paling bijak berdasarkan efisiensi energi. |
| **Detail Transportasi Publik**| `/publicTransportDetail` | - Informasi rute koridor, peta jalur, dan tarif flat kartu pembayaran elektronik (e-money). |
| **Jadwal Keberangkatan** | `/departureSchedule` | - Tabel jadwal kedatangan armada bus/kereta berikutnya secara berkala. |
| **Rangkuman Perjalanan (Trip Recap)**| `/tripRecap` | - Kartu rekapitulasi setelah perjalanan selesai: Total langkah kaki, kalori terbakar, dan gram CO₂ yang berhasil dihemat dibandingkan jika menggunakan kendaraan pribadi bermesin bensin. |

---

### 🌦️ 4. Modul Pemantauan Cuaca (`features/weather`)

Membantu pengguna merencanakan perjalanan jalan kaki atau transit umum secara aman:

| Halaman | Rute | Fitur & Komponen Antarmuka |
| :--- | :--- | :--- |
| **Detail Cuaca** | `/weatherDetail` | - Prakiraan kondisi cuaca saat ini (Suhu °C, terasa seperti/feels-like, status cuaca).<br>- Prakiraan cuaca per jam (*Hourly Forecast*).<br>- Metrik parameter lingkungan: Kelembapan (*Humidity %*), Kecepatan Angin (*km/h*), Indeks Ultraviolet (UV), dan Indeks Kualitas Udara (*Air Quality Index - AQI*).<br>- Rekomendasi perlengkapan ramah pejalan kaki (contoh: *"Bawa payung lipat / kenakan topi ramah UV"*). |

---

### 👤 5. Modul Profil & Pengaturan (`features/profile`)

Menyediakan personalisasi dan kontrol privasi akun pengguna:

| Halaman / Komponen | Rute | Fitur & Komponen Antarmuka |
| :--- | :--- | :--- |
| **Halaman Profil** | `/profile` | - Foto profil pengguna (didukung gambar avatar lokal atau foto kustom).<br>- Nama pengguna dan status lencana penjelajah ramah lingkungan (*Eco-Traveler Level*).<br>- Tombol navigasi cepat: Edit Profil, Pengaturan Akun, dan Riwayat Perjalanan. |
| **Edit Profil** | `/editProfile` | - Pengubahan nama profil secara dinamis.<br>- Pemilihan foto profil melalui modal bottom sheet yang mendukung sumber **Kamera** atau **Galeri Foto**. |
| **Antarmuka Kamera** | `/camera` | - Antarmuka pengambilan foto langsung dari aplikasi untuk pembaruan avatar. |
| **Pengaturan Akun** | `/settings` | - Menu keamanan: Ubah Nomor HP, Ubah Alamat Email, Ubah Kata Sandi.<br>- Menu informasi: Kebijakan Privasi, Tentang Aplikasi, Syarat & Ketentuan.<br>- **Dialog Keluar Akun (`LogoutDialog`)**: Konfirmasi keluar dengan pengalihan ke halaman `/login`.<br>- **Dialog Hapus Akun (`DeleteAccountDialog`)**: Konfirmasi keamanan ganda untuk penghapusan data akun pengguna secara permanen. |

---

### 💬 6. Asisten Virtual Ecowalk & Notifikasi

- **Ecowalk Assistant (Chatbot Modal)**:
  - Dapat diakses kapan saja melalui tab tengah bilah navigasi bawah (ikon chat hati) atau floating action button di Beranda.
  - Memberikan saran instan rute pariwisata, informasi cuaca, dan panduan penggunaan transit publik.
- **Pusat Notifikasi (`/notifications`)**:
  - Pemberitahuan real-time terkait perubahan jadwal transportasi publik, peringatan hujan mendadak, serta promo tiket masuk destinasi wisata.

---

### 📄 7. Halaman Statis & Informasi Hukum (`features/static_pages`)

- **Splash Page (`/splash`)**: Animasi logo pembuka dan inisialisasi state aplikasi.
- **Tentang Kami (`/aboutUs`)**: Visi, misi, dan latar belakang pengembangan aplikasi Ecowalk.
- **Kebijakan Privasi (`/privacyPolicy`)**: Perlindungan data pribadi dan privasi pengguna.
- **Syarat & Ketentuan (`/termsOfService`)**: Ketentuan hukum penggunaan layanan aplikasi.
- **Halaman Penampung (`EmptyPlaceholderPage`)**: Penanganan graceful fallback saat data kosong.

---

## 3. Matriks Rute Navigasi Lengkap (35 Rute)

| No | Path Rute | Widget Target | Modul Fitur |
| :---: | :--- | :--- | :--- |
| 1 | `/splash` | `SplashPage` | `static_pages` |
| 2 | `/login` | `LoginPage` | `auth` |
| 3 | `/register` | `RegisterPage` | `auth` |
| 4 | `/verificationWithNoHP` | `NoHpOTPPage` | `auth` |
| 5 | `/verificationWithEmail`| `EmailOtpPage` | `auth` |
| 6 | `/forpassNoHp` | `ForpassNohpPage` | `auth` |
| 7 | `/forpassEmail` | `ForpassEmailPage` | `auth` |
| 8 | `/changePass` | `ChangePassPage` | `auth` |
| 9 | `/home` | `MainNavigationWrapper(initialIndex: 0)` | `home` / `shared` |
| 10 | `/detailDestination` | `DestinationDetailPage` | `home` |
| 11 | `/reviews` | `RatingsReviewsPage` | `home` |
| 12 | `/addReview` | `AddReviewPage` | `home` |
| 13 | `/profile` | `MainNavigationWrapper(initialIndex: 3)` | `profile` / `shared` |
| 14 | `/editProfile` | `EditProfilePage` | `profile` |
| 15 | `/camera` | `CameraPage` | `profile` |
| 16 | `/settings` | `SettingsPage` | `profile` |
| 17 | `/changePhone` | `ChangePhonePage` | `auth` |
| 18 | `/changeEmail` | `ChangeEmailPage` | `auth` |
| 19 | `/updatePassword` | `UpdatePasswordPage` | `auth` |
| 20 | `/verifyPhoneUpdate` | `VerifyPhoneUpdatePage` | `auth` |
| 21 | `/verifyEmailUpdate` | `VerifyEmailUpdatePage` | `auth` |
| 22 | `/privacyPolicy` | `PrivacyPolicyPage` | `static_pages` |
| 23 | `/aboutUs` | `AboutUsPage` | `static_pages` |
| 24 | `/termsOfService` | `TermsOfServicePage` | `static_pages` |
| 25 | `/categoryDetail` | `CategoryDetailPage` | `home` |
| 26 | `/weatherDetail` | `WeatherDetailPage` | `weather` |
| 27 | `/notifications` | `NotificationsPage` | `notifications` |
| 28 | `/tripRecap` | `TripRecapPage` | `recommendation` |
| 29 | `/recentlyViewed` | `RecentlyViewedPage` | `home` |
| 30 | `/recommendation` | `MainNavigationWrapper(initialIndex: 1)` | `recommendation` / `shared` |
| 31 | `/routeRecommendation` | `RouteRecommendationPage` | `recommendation` |
| 32 | `/vehicleAnalysis` | `VehicleAnalysisPage` | `recommendation` |
| 33 | `/publicTransportDetail` | `PublicTransportDetailPage` | `recommendation` |
| 34 | `/departureSchedule` | `DepartureSchedulePage` | `recommendation` |
