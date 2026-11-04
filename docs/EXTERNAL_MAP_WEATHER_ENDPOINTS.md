# Endpoint Eksternal Map dan Weather

Dokumen ini mencatat layanan eksternal yang benar-benar dipanggil oleh aplikasi untuk menampilkan peta dan informasi cuaca. Endpoint diambil dari implementasi saat ini; fitur lain seperti geocoding, pencarian lokasi, dan navigasi turn-by-turn tidak termasuk dalam integrasi ini.

## Ringkasan

| Fitur | Penyedia | Endpoint | Tujuan |
|---|---|---|---|
| Peta | OpenStreetMap Standard Tiles | `https://tile.openstreetmap.org/{z}/{x}/{y}.png` | Mengambil gambar tile peta berdasarkan zoom dan koordinat tile. |
| Prakiraan cuaca | Open-Meteo Forecast API | `https://api.open-meteo.com/v1/forecast` | Mendapatkan kondisi saat ini, prakiraan per jam, dan ringkasan harian. |
| Kualitas udara | Open-Meteo Air Quality API | `https://air-quality-api.open-meteo.com/v1/air-quality` | Mendapatkan indeks kualitas udara US AQI dan European AQI. |

Endpoint cuaca didefinisikan di `lib/core/constants/api_constants.dart` dan dipanggil oleh `lib/features/weather/data/datasources/weather_remote_data_source.dart`. Tile peta dikonfigurasi langsung di `lib/shared/widgets/map/app_map_view.dart` menggunakan `flutter_map`.

## Peta: OpenStreetMap

### Tile endpoint

```text
GET https://tile.openstreetmap.org/{z}/{x}/{y}.png
```

`z` adalah level zoom, sedangkan `x` dan `y` adalah koordinat tile pada level tersebut. Aplikasi menggunakan zoom awal yang diberikan tiap layar, membatasi interaksi pada zoom 3–18, dan mengatur batas tile maksimum ke 19. Permintaan tile dijalankan oleh `flutter_map`; tidak ada permintaan geocoding atau routing ke layanan OpenStreetMap pada kode saat ini.

Tidak diperlukan API key untuk konfigurasi yang ada. Peta menampilkan label atribusi OpenStreetMap di atas map view melalui `AppMapView`. Penggunaan layanan tile publik harus mematuhi [Tile Usage Policy OpenStreetMap](https://operations.osmfoundation.org/policies/tiles/) dan mencantumkan atribusi yang jelas; informasi lisensi tersedia di [OpenStreetMap Copyright](https://www.openstreetmap.org/copyright). Untuk trafik besar atau kebutuhan produksi dengan jaminan layanan, gunakan penyedia tile yang sesuai atau host sendiri, bukan mengandalkan kapasitas layanan publik.

## Cuaca: Open-Meteo

### Forecast endpoint

```text
GET https://api.open-meteo.com/v1/forecast
```

Parameter yang dikirim aplikasi:

| Parameter | Nilai saat ini | Makna |
|---|---|---|
| `latitude` | Default `-6.1950` | Garis lintang lokasi (default Menteng, Jakarta Pusat). |
| `longitude` | Default `106.8330` | Garis bujur lokasi (default Menteng, Jakarta Pusat). |
| `current` | `temperature_2m,relative_humidity_2m,is_day,weather_code,wind_speed_10m` | Suhu, kelembapan relatif, siang/malam, kode cuaca WMO, dan kecepatan angin saat ini. |
| `hourly` | `temperature_2m,weather_code` | Suhu dan kode cuaca per jam. |
| `daily` | `weather_code,temperature_2m_max,temperature_2m_min` | Kode cuaca serta suhu maksimum dan minimum per hari. |
| `timezone` | `Asia/Jakarta` | Zona waktu untuk waktu prakiraan dan nilai harian. |

Contoh URL request (dipersingkat agar mudah dibaca):

```text
https://api.open-meteo.com/v1/forecast?latitude=-6.195&longitude=106.833&current=temperature_2m,relative_humidity_2m,is_day,weather_code,wind_speed_10m&hourly=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=Asia%2FJakarta
```

Implementasi mengandalkan satuan default API untuk suhu (°C) dan kecepatan angin (km/jam), yang sesuai dengan tampilan aplikasi. Dokumentasi parameter dan satuan tersedia di [Open-Meteo Forecast API](https://open-meteo.com/en/docs).

### Air Quality endpoint

```text
GET https://air-quality-api.open-meteo.com/v1/air-quality
```

Parameter yang dikirim:

| Parameter | Nilai | Makna |
|---|---|---|
| `latitude` | Sama dengan request forecast | Garis lintang lokasi. |
| `longitude` | Sama dengan request forecast | Garis bujur lokasi. |
| `current` | `us_aqi,european_aqi` | Indeks kualitas udara saat ini berdasarkan skala US AQI dan European AQI. |

Endpoint kualitas udara bersifat opsional bagi proses pemuatan cuaca: bila gagal, aplikasi tetap menampilkan forecast dan menggunakan nilai AQI fallback pada model. Lihat [Open-Meteo Air Quality API](https://open-meteo.com/en/docs/air-quality-api) untuk definisi parameter dan [ketentuan atribusi Open-Meteo](https://open-meteo.com/en/terms).

## Perilaku aplikasi saat request gagal

- Request forecast gagal atau jaringan tidak tersedia: `WeatherRemoteDataSource` mengembalikan `WeatherModel.mockFallback(...)` agar layar tetap memiliki data.
- Request kualitas udara gagal: data AQI diabaikan dan model memakai nilai default/fallback; forecast tetap diproses.
- Tile peta gagal dimuat: peta dasar bergantung pada jaringan dan dapat menampilkan tile kosong sampai koneksi tersedia. Marker, polyline, dan kontrol map berasal dari aplikasi, bukan dari endpoint tile.
- Batas waktu koneksi dan respons klien API saat ini masing-masing 15 detik (`ApiConstants.connectTimeout` dan `receiveTimeout`).

## Referensi kode

- `lib/shared/widgets/map/app_map_view.dart` — URL tile, zoom, dan atribusi peta.
- `lib/core/constants/api_constants.dart` — base URL serta path endpoint cuaca.
- `lib/features/weather/data/datasources/weather_remote_data_source.dart` — parameter request dan fallback.
- `lib/features/weather/presentation/controllers/weather_controller.dart` — koordinat/lokasi default serta pemuatan data.
- `lib/features/weather/data/models/weather_model.dart` — pemetaan respons Open-Meteo ke model aplikasi.

## Referensi penyedia

- [OpenStreetMap Tile Usage Policy](https://operations.osmfoundation.org/policies/tiles/)
- [OpenStreetMap Copyright dan atribusi](https://www.openstreetmap.org/copyright)
- [Open-Meteo Forecast API](https://open-meteo.com/en/docs)
- [Open-Meteo Air Quality API](https://open-meteo.com/en/docs/air-quality-api)
- [Open-Meteo Terms](https://open-meteo.com/en/terms)
