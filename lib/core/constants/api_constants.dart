/// Centralized API Constants for upcoming external integrations
/// (e.g. Weather API, Public Transit API, Tourism / Destination API, Auth API).
class ApiConstants {
  ApiConstants._();

  // Base URLs (can be swapped between development & production)
  static const String baseApiUrl = 'https://api.example.com/v1';
  static const String openWeatherBaseUrl = 'https://api.openweathermap.org/data/2.5';

  // API Endpoints Placeholder
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
