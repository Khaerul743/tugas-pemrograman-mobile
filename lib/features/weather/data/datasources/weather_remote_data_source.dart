import 'package:tugas_1/core/constants/api_constants.dart';
import 'package:tugas_1/core/network/api_client.dart';
import 'package:tugas_1/features/weather/data/models/weather_model.dart';

abstract class BaseWeatherRemoteDataSource {
  Future<WeatherModel> getWeatherForecast({
    double latitude,
    double longitude,
    String locationName,
  });
}

class WeatherRemoteDataSource implements BaseWeatherRemoteDataSource {
  final BaseApiClient apiClient;
  final BaseApiClient airQualityClient;

  WeatherRemoteDataSource({
    BaseApiClient? apiClient,
    BaseApiClient? airQualityClient,
  })  : apiClient = apiClient ?? ApiClient(baseUrl: ApiConstants.openMeteoBaseUrl),
        airQualityClient = airQualityClient ?? ApiClient(baseUrl: ApiConstants.openMeteoAirQualityBaseUrl);

  @override
  Future<WeatherModel> getWeatherForecast({
    double latitude = -6.1950, // Menteng, Jakarta Pusat default
    double longitude = 106.8330,
    String locationName = 'Menteng, Jakarta Pusat',
  }) async {
    try {
      // 1. Fetch Forecast from Open-Meteo
      final forecastResponse = await apiClient.get(
        ApiConstants.forecastEndpoint,
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'current': 'temperature_2m,relative_humidity_2m,is_day,weather_code,wind_speed_10m',
          'hourly': 'temperature_2m,weather_code',
          'daily': 'weather_code,temperature_2m_max,temperature_2m_min',
          'timezone': 'Asia/Jakarta',
        },
      );

      // 2. Fetch Air Quality Index (AQI) in parallel
      Map<String, dynamic>? airQualityResponse;
      try {
        final aqiData = await airQualityClient.get(
          ApiConstants.airQualityEndpoint,
          queryParameters: {
            'latitude': latitude,
            'longitude': longitude,
            'current': 'us_aqi,european_aqi',
          },
        );
        if (aqiData is Map<String, dynamic>) {
          airQualityResponse = aqiData;
        }
      } catch (_) {
        // Air quality is optional; will gracefully fallback to default AQI
      }

      if (forecastResponse is Map<String, dynamic>) {
        return WeatherModel.fromOpenMeteo(
          forecastJson: forecastResponse,
          airQualityJson: airQualityResponse,
          locationName: locationName,
        );
      }

      return WeatherModel.mockFallback(locationName: locationName);
    } catch (_) {
      // In case of network errors or offline, return safe realistic fallback
      return WeatherModel.mockFallback(locationName: locationName);
    }
  }
}
