# 🌐 Panduan Integrasi API Eksternal (*API Integration Guide*)

Dokumen ini merupakan panduan teknis bagi pengembang untuk mengintegrasikan layanan backend dan REST API pihak ketiga ke dalam aplikasi **Ecowalk**. Arsitektur *Feature-First* yang telah dibangun dirancang khusus agar integrasi API dapat dilakukan secara modular dan terisolasi tanpa mengacaukan antarmuka pengguna.

---

## 1. Fondasi Jaringan yang Telah Disiapkan

Proyek telah dilengkapi dengan fondasi komunikasi jaringan terpusat di dalam folder `lib/core/`:

### A. Kontrak Klien Jaringan (`lib/core/network/api_client.dart`)
Menyediakan abstraksi `BaseApiClient` sehingga pemanggilan HTTP di seluruh aplikasi terstandarisasi:

```dart
abstract class BaseApiClient {
  Future<dynamic> get(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String endpoint, {Map<String, String>? headers, dynamic body});
  Future<dynamic> put(String endpoint, {Map<String, String>? headers, dynamic body});
  Future<dynamic> delete(String endpoint, {Map<String, String>? headers});
}
```

Ketika paket seperti `http` atau `dio` diimplementasikan secara penuh, implementasi cukup diperbarui di dalam kelas `ApiClient`, sementara modul-modul fitur di `lib/features/` tidak perlu diubah sama sekali.

### B. Konstanta Endpoint (`lib/core/constants/api_constants.dart`)
Seluruh base URL, rute endpoint, dan konfigurasi timeout dikonsolidasikan dalam satu berkas:
- **`baseApiUrl`**: Base URL untuk server backend utama aplikasi.
- **`openWeatherBaseUrl`**: Base URL untuk layanan cuaca publik (misal: OpenWeatherMap).
- **`connectTimeout` & `receiveTimeout`**: Standarisasi batas waktu tunggu koneksi (default 15 detik).

---

## 2. Pola Arsitektur Integrasi Fitur (*Repository Pattern*)

Untuk menerapkan pemisahan tugas (*Separation of Concerns*), penambahan integrasi API pada setiap fitur dianjurkan mengikuti struktur 3 sub-layer berikut:

```text
lib/features/<nama_fitur>/
├── data/
│   ├── datasources/
│   │   └── <fitur>_remote_data_source.dart   # Melakukan panggilan HTTP langsung melalui ApiClient
│   ├── models/
│   │   └── <fitur>_model.dart                # Deserialisasi JSON (fromJson / toJson)
│   └── repositories/
│       └── <fitur>_repository_impl.dart      # Implementasi logika repository & penanganan error
│
├── domain/
│   ├── entities/
│   │   └── <fitur>_entity.dart               # Struktur data murni untuk UI
│   └── repositories/
│       └── <fitur>_repository.dart           # Kontrak abstrak interface repository
│
└── presentation/
    ├── <fitur>_page.dart                     # Antarmuka pengguna (UI)
    └── widgets/                              # Widget modular pendukung halaman
```

---

## 3. Contoh Rencana Implementasi Nyata

### Kasus A: Integrasi Cuaca (`features/weather`)

1. **Model Data (`weather_model.dart`)**:
```dart
class WeatherModel {
  final double temperature;
  final String condition;
  final int humidity;
  final double windSpeed;
  final int aqi;

  WeatherModel({
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.aqi,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'] as String,
      humidity: json['main']['humidity'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      aqi: json['aqi'] ?? 42,
    );
  }
}
```

2. **Remote Data Source (`weather_remote_data_source.dart`)**:
```dart
class WeatherRemoteDataSource {
  final BaseApiClient apiClient;

  WeatherRemoteDataSource(this.apiClient);

  Future<WeatherModel> fetchCurrentWeather(double lat, double lon) async {
    final response = await apiClient.get(
      '/weather',
      queryParameters: {
        'lat': lat.toString(),
        'lon': lon.toString(),
        'units': 'metric',
        'appid': '<YOUR_API_KEY>',
      },
    );
    return WeatherModel.fromJson(response);
  }
}
```

---

### Kasus B: Integrasi Rute & Transit (`features/recommendation`)

Untuk fitur **Pencarian Rute** dan **Analisis Kendaraan**:
- **Endpoint**: `GET /transit/routes?origin={origin}&destination={destination}`
- **Data yang Diterima**:
  - Daftar langkah rute transit (nama halte asal, koridor bus, stasiun transit, halte tujuan).
  - Estimasi waktu tempuh (*estimated duration*).
  - Kalkulasi emisi karbon komparatif:
    - Emisi Transportasi Publik (rata-rata ~35g CO₂/penumpang/km).
    - Emisi Kendaraan Pribadi (rata-rata ~120g CO₂/km untuk motor, ~190g CO₂/km untuk mobil).
  - Estimasi biaya tarif flat (Rp 3.500 Transjakarta, Rp 3.000–6.000 KRL).

---

### Kasus C: Integrasi Autentikasi (`features/auth`)

Untuk integrasi masuk (*login*) dan pendaftaran (*register*):
- **Endpoint Masuk**: `POST /auth/login` dengan payload `{ "username": "...", "password": "..." }`.
- **Response**: Mengembalikan token akses JWT (`accessToken`), token penyegaran (`refreshToken`), serta objek data profil pengguna.
- **Penyimpanan Token**: Token dapat disimpan di penyimpanan lokal terenkripsi (*Flutter Secure Storage* atau *SharedPreferences*).
- **Interseptor Otomatis**: Menyisipkan header `Authorization: Bearer <token>` pada setiap permintaan privat berikutnya melalui `ApiClient`.

---

## 4. Penanganan Kesalahan (*Error Handling*)

Gunakan kelas `ApiException` yang sudah didefinisikan di [`lib/core/network/api_client.dart`](file:///c:/Users/Pongo/Documents/projects/flutter/tugas_pemrograman_mobile/tugas_1/lib/core/network/api_client.dart) untuk memberikan feedback yang ramah pengguna pada antarmuka:

```dart
try {
  final weather = await weatherRepository.getWeather();
  // Update state sukses pada UI
} on ApiException catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(e.message),
      backgroundColor: Colors.red,
    ),
  );
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Terjadi kesalahan yang tidak terduga.'),
      backgroundColor: Colors.red,
    ),
  );
}
```

---

## 5. Rangkuman Langkah Lanjutan Developer

1. **Tambahkan dependensi paket jaringan** ke `pubspec.yaml` (misal: `http: ^1.2.0` atau `dio: ^5.4.0`).
2. **Lengkapi metode HTTP** di [api_client.dart](file:///c:/Users/Pongo/Documents/projects/flutter/tugas_pemrograman_mobile/tugas_1/lib/core/network/api_client.dart) dengan decoding JSON dan interceptor.
3. **Tambahkan model data dan remote data source** di folder fitur masing-masing (`features/weather/data/`, `features/recommendation/data/`, dsb.).
4. **Hubungkan State UI** (misalnya menggunakan `FutureBuilder`, `ValueNotifier`, `Bloc`, atau `Riverpod`) ke remote data source tersebut.
