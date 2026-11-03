import 'package:flutter/foundation.dart';
import 'package:tugas_1/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:tugas_1/features/weather/data/models/weather_model.dart';

/// Centralized Weather Controller / State Manager
/// Shares reactive weather data across HomePage and WeatherDetailPage.
class WeatherController extends ChangeNotifier {
  // Singleton pattern for accessible shared weather state across pages
  static final WeatherController _instance = WeatherController._internal();
  static WeatherController get instance => _instance;

  WeatherController._internal() {
    // Automatically initialize with safe realistic data, then trigger background fetch
    _weather = WeatherModel.mockFallback();
  }

  final BaseWeatherRemoteDataSource _remoteDataSource = WeatherRemoteDataSource();

  WeatherModel? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel get weather => _weather ?? WeatherModel.mockFallback();
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Fetch latest weather from Open-Meteo API
  Future<void> fetchWeather({
    double latitude = -6.1950,
    double longitude = 106.8330,
    String locationName = 'Menteng, Jakarta Pusat',
    bool forceRefresh = false,
  }) async {
    // Avoid redundant calls if already loaded unless forceRefresh is true
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _remoteDataSource.getWeatherForecast(
        latitude: latitude,
        longitude: longitude,
        locationName: locationName,
      );
      _weather = result;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Gagal memuat cuaca terbaru: $e';
      // Keep existing data or fallback
      _weather ??= WeatherModel.mockFallback(locationName: locationName);
      notifyListeners();
    }
  }
}
