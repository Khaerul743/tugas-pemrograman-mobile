/// Centralized API Constants for upcoming external integrations
/// (e.g. Weather API, Public Transit API, Tourism / Destination API, Auth API).
class ApiConstants {
  ApiConstants._();

  // Base URLs (can be swapped between development & production)
  static const String baseApiUrl = 'https://api.example.com/v1';
  static const String openMeteoBaseUrl = 'https://api.open-meteo.com/v1';
  static const String openMeteoAirQualityBaseUrl = 'https://air-quality-api.open-meteo.com/v1';

  // API Endpoints
  static const String forecastEndpoint = '/forecast';
  static const String airQualityEndpoint = '/air-quality';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String weatherEndpoint = '/weather';
  static const String destinationsEndpoint = '/destinations';
  static const String routesEndpoint = '/transit/routes';
  static const String schedulesEndpoint = '/transit/schedules';

  // Network timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
