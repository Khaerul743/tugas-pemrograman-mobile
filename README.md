# Tugas 1 - Pemrograman Mobile
## Aplikasi Autentikasi "Ecowalk"

Dokumentasi implementasi aplikasi mobile berbasis Flutter untuk pemenuhan tugas mata kuliah Pemrograman Mobile.

---

### Informasi Mahasiswa

| Keterangan | Data |
| :--- | :--- |
| **Nama Lengkap** | Khaerul Lutfi |
| **NIM** | 41824010057 |
| **Mata Kuliah** | Pemrograman Mobile |
| **Tugas** | Tugas 1 - Antarmuka & Validasi Form Autentikasi |
| **Framework** | Flutter (Dart SDK) |

---

## 1. Deskripsi Aplikasi

**Ecowalk** adalah aplikasi mobile yang dirancang dengan sistem autentikasi lengkap dan alur pengguna (*user flow*) yang konsisten. Proyek ini mencakup alur registrasi akun baru, verifikasi OTP, proses masuk (*login*), alur lupa kata sandi dengan opsi Email maupun Nomor HP, pembaruan kata sandi, hingga navigasi ke halaman profil pengguna.

Seluruh formulir input telah dilengkapi dengan **validasi form** (*client-side form validation*) yang ketat guna memastikan keabsahan data pengguna sebelum diproses ke langkah berikutnya.

---

## 2. Fitur & Validasi Form

Aplikasi ini mengimplementasikan validasi form interaktif pada setiap halaman formulir:

### A. Halaman Registrasi (`/register`)
- **Nama Pengguna**: Wajib diisi, minimal 3 karakter.
- **Alamat Email**: Wajib diisi, format email divalidasi menggunakan pola ekspresi reguler (*RegExp*).
- **Nomor HP**: Wajib diisi, hanya boleh berisi angka, minimal 10 digit.
- **Kata Sandi**: Wajib diisi, visibilitas dapat diubah (*toggle obscure text*), minimal 6 karakter.
- **Konfirmasi Kata Sandi**: Wajib diisi, nilai harus identik dengan kolom Kata Sandi.
- **Persetujuan Ketentuan (*Checkbox*)**: Wajib dicentang. Jika belum dicentang saat menekan tombol "BUAT AKUN", sistem memunculkan notifikasi peringatan (*SnackBar*).

### B. Halaman Masuk (`/login`)
- **Nama Pengguna**: Wajib diisi (*tidak boleh kosong*).
- **Kata Sandi**: Wajib diisi, minimal 6 karakter.
- **Fitur Tambahan**: Tombol pintas masuk via Google (*Social Login* UI), tautan ke halaman lupa kata sandi, serta navigasi pendaftaran.

### C. Halaman Lupa Kata Sandi (`/forpassNoHp` & `/forpassEmail`)
- Dibangun menggunakan widget modular yang dapat digunakan kembali (`ForpassTemplate`).
- **Opsi Nomor HP**: Wajib diisi, validasi format numerik, minimal 10 digit.
- **Opsi Email**: Wajib diisi, validasi format alamat email yang valid.
- Pengguna dapat beralih metode pemulihan secara fleksibel (*Gunakan Email / Gunakan No Hp*).

### D. Halaman Ubah Kata Sandi (`/changePass`)
- **Kata Sandi Baru**: Wajib diisi, minimal 6 karakter.
- **Konfirmasi Kata Sandi**: Wajib diisi dan harus cocok dengan kata sandi baru.
- Penyesuaian tata letak presisi (*alignment*) antara *hint text*, teks input, dan ikon gembok serta ikon visibilitas mata.
- Menampilkan *SnackBar* konfirmasi sukses saat validasi berhasil dan mengarahkan kembali pengguna ke halaman masuk.

### E. Halaman Pendukung
- **Splash Screen (`/splash`)**: Halaman transisi pembuka dengan *branding* logo Ecowalk.
- **Verifikasi OTP (`/verificationWithNoHP` & `/verificationWithEmail`)**: Antarmuka masukan kode OTP dengan *countdown timer*.
- **Halaman Profil (`/profile`)**: Halaman beranda/profil pengguna setelah berhasil login.

---

## 3. Struktur Direktori Proyek

Struktur folder proyek diatur secara rapi dan modular untuk memisahkan logika halaman, komponen widget, dan aset:

```text
tugas_1/
├── android/                        # Konfigurasi native platform Android
├── ios/                            # Konfigurasi native platform iOS
├── windows/                        # Konfigurasi native platform Windows desktop
├── lib/
│   ├── assets/
│   │   └── images/                 # Aset grafik, ikon SVG, dan ilustrasi
│   │       ├── google_logo.svg
│   │       ├── kucing.jpg
│   │       ├── runner.svg
│   │       └── runner_green.svg
│   │
│   ├── pages/                      # Seluruh layar antarmuka aplikasi
│   │   ├── change_pass_page.dart   # Halaman reset/ubah kata sandi
│   │   ├── email_otp_page.dart     # Halaman input OTP via Email
│   │   ├── forpass_email_page.dart # Halaman lupa sandi via Email
│   │   ├── forpass_noHp_page.dart  # Halaman lupa sandi via Nomor HP
│   │   ├── login_page.dart         # Halaman masuk (Login)
│   │   ├── noHp_otp_page.dart      # Halaman input OTP via Nomor HP
│   │   ├── profile_page.dart       # Halaman profil pengguna
│   │   ├── register_page.dart      # Halaman pendaftaran (Register)
│   │   └── splash_page.dart        # Halaman splash screen
│   │
│   ├── widgets/                    # Komponen UI modular yang dapat digunakan ulang
│   │   ├── forpass_template.dart   # Template antarmuka lupa kata sandi
│   │   ├── header_clipper.dart     # Custom clipper lengkungan dekoratif header
│   │   ├── logo.dart               # Komponen logo aplikasi Ecowalk
│   │   └── otp_template.dart       # Template input digit verifikasi OTP
│   │
│   └── main.dart                   # Titik masuk utama aplikasi & konfigurasi rute
│
├── test/                           # Berkas pengujian unit & widget
├── pubspec.yaml                    # Manajemen paket dependensi dan registrasi aset
├── analysis_options.yaml           # Konfigurasi aturan linting Flutter
└── README.md                       # Dokumentasi proyek
```

---

## 4. Daftar Rute Navigasi (*Named Routes*)

Aplikasi menggunakan sistem navigasi berbasis rute nama (*Named Routes*) yang terpusat di `main.dart`:

| Rute | Widget Halaman | Deskripsi |
| :--- | :--- | :--- |
| `/splash` | `SplashPage` | Tampilan pembuka aplikasi (*Initial Route*) |
| `/login` | `LoginPage` | Layar login akun |
| `/register` | `RegisterPage` | Layar pembuatan akun baru |
| `/forpassNoHp` | `ForpassNohpPage` | Pemulihan kata sandi via No HP |
| `/forpassEmail` | `ForpassEmailPage` | Pemulihan kata sandi via Email |
| `/verificationWithNoHP` | `NoHpOTPPage` | Verifikasi kode OTP nomor handphone |
| `/verificationWithEmail` | `EmailOtpPage` | Verifikasi kode OTP alamat email |
| `/changePass` | `ChangePassPage` | Pengaturan kata sandi baru |
| `/profile` | `ProfilePage` | Layar profil pengguna setelah autentikasi |

---

## 5. Teknologi & Dependensi

Proyek ini dibangun menggunakan spesifikasi berikut:

- **Bahasa Pemrograman**: Dart (`^3.13.4`)
- **Framework**: Flutter SDK
- **Dependensi Utama**:
  - `flutter_svg: ^2.0.17` — Merender aset grafis berbasis vektor SVG.
  - `cupertino_icons: ^1.0.8` — Kumpulan ikon gaya Cupertino.
- **Peralatan Analisis Kode**:
  - `flutter_lints: ^6.0.0` — Memastikan kualitas dan standar konvensi penulisan kode Dart.

---

## 6. Petunjuk Menjalankan Aplikasi (*How to Run*)

Ikuti langkah-langkah di bawah ini untuk menginstal dependensi dan menjalankan aplikasi di lingkungan pengembangan lokal:

### Prasyarat
1. Telah menginstal **Flutter SDK** (versi 3.13 atau yang lebih baru).
2. Telah menginstal **Android Studio** atau **VS Code** beserta ekstensi Flutter & Dart.
3. Telah mengonfigurasi emulator Android/iOS atau mengaktifkan mode *USB Debugging* pada perangkat fisik.

### Langkah Instalasi & Menjalankan

1. **Buka Terminal / Command Prompt**:
   Masuk ke direktori proyek:
   ```bash
   cd tugas-pemrograman-mobile
   ```

2. **Unduh Paket Dependensi**:
   Jalankan perintah berikut untuk mengunduh semua library yang diperlukan:
   ```bash
   flutter pub get
   ```

3. **Periksa Ketersediaan Perangkat / Emulator**:
   Pastikan terdapat perangkat atau emulator yang terdeteksi:
   ```bash
   flutter devices
   ```

4. **Jalankan Aplikasi**:
   Eksekusi perintah berikut untuk memulai proses *build* dan menjalankan aplikasi:
   ```bash
   flutter run
   ```

5. **Menjalankan pada Target Perangkat Tertentu (Opsional)**:
   ```bash
   # Contoh menjalankan pada emulator Android:
   flutter run -d android

   # Contoh menjalankan pada Google Chrome (Web):
   flutter run -d chrome

   # Contoh menjalankan pada Windows Desktop:
   flutter run -d windows
   ```

6. **Pemeriksaan Kualitas Kode (*Linting & Analysis*)**:
   Untuk memverifikasi bahwa tidak terdapat kesalahan sintaksis atau peringatan analisis kode:
   ```bash
   flutter analyze
   ```

---

## 7. Catatan Implementasi & Desain

- **Keamanan Memori (*Memory Leak Prevention*)**: Seluruh `TextEditingController` pada halaman stateful telah ditutup menggunakan `dispose()` sesuai kaidah *lifecycle* widget Flutter.
- **Pencegahan Render Overflow**: Halaman formulir dirancang adaptif terhadap pemunculan keyboard virtual layar sentuh.
- **Konsistensi UI/UX**: Seluruh komponen masukan teks dan tombol aksi menerapkan warna tema seragam (`#1A6556`) untuk mempertahankan identitas visual *brand* Ecowalk.