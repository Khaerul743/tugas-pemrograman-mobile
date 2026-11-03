/// Model representations and Open-Meteo parsers for weather and air quality.
class WeatherModel {
  final String locationName;
  final DateTime date;
  final CurrentWeatherData current;
  final List<HourlyForecastData> hourly;
  final List<DailyForecastData> daily;

  const WeatherModel({
    required this.locationName,
    required this.date,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  /// Factory constructor to parse Open-Meteo response
  factory WeatherModel.fromOpenMeteo({
    required Map<String, dynamic> forecastJson,
    Map<String, dynamic>? airQualityJson,
    String locationName = 'Menteng, Jakarta Pusat',
  }) {
    final currentMap = forecastJson['current'] as Map<String, dynamic>? ?? {};
    final hourlyMap = forecastJson['hourly'] as Map<String, dynamic>? ?? {};
    final dailyMap = forecastJson['daily'] as Map<String, dynamic>? ?? {};

    // 1. Current Weather
    final temp = (currentMap['temperature_2m'] as num?)?.toDouble() ?? 30.0;
    final humidity = (currentMap['relative_humidity_2m'] as num?)?.toInt() ?? 75;
    final weatherCode = (currentMap['weather_code'] as num?)?.toInt() ?? 2;
    final isDay = (currentMap['is_day'] as num?)?.toInt() == 1;
    final windSpeed = (currentMap['wind_speed_10m'] as num?)?.toDouble() ?? 12.0;

    // Air Quality (US AQI / European AQI)
    final aqiCurrent = airQualityJson?['current'] as Map<String, dynamic>?;
    final aqi = (aqiCurrent?['us_aqi'] as num?)?.toDouble() ??
        (aqiCurrent?['european_aqi'] as num?)?.toDouble() ??
        39.1;

    final condition = WeatherIconMapper.mapCondition(weatherCode, isDay: isDay, temp: temp);

    final currentData = CurrentWeatherData(
      temperature: temp,
      humidity: humidity,
      weatherCode: weatherCode,
      isDay: isDay,
      windSpeed: windSpeed,
      aqi: aqi,
      conditionText: condition.description,
      iconPath: condition.iconPath,
    );

    // 2. Hourly Forecast (Get the next 7 key time slots)
    final hourlyList = <HourlyForecastData>[];
    final times = (hourlyMap['time'] as List<dynamic>?)?.cast<String>() ?? [];
    final temps = (hourlyMap['temperature_2m'] as List<dynamic>?) ?? [];
    final codes = (hourlyMap['weather_code'] as List<dynamic>?) ?? [];

    final now = DateTime.now();
    for (int i = 0; i < times.length && hourlyList.length < 7; i++) {
      try {
        final parsedTime = DateTime.parse(times[i]);
        // Only include current hour and future hours at 2-3 hour steps
        if (parsedTime.isAfter(now.subtract(const Duration(hours: 1)))) {
          final hTemp = (temps[i] as num).toDouble();
          final hCode = (codes[i] as num).toInt();
          final isHourDay = parsedTime.hour >= 6 && parsedTime.hour < 18;
          final hCond = WeatherIconMapper.mapCondition(hCode, isDay: isHourDay, temp: hTemp);

          final timeLabel = hourlyList.isEmpty
              ? 'Sekarang'
              : '${parsedTime.hour.toString().padLeft(2, '0')}:00';

          hourlyList.add(HourlyForecastData(
            timeLabel: timeLabel,
            temperature: hTemp,
            weatherCode: hCode,
            iconPath: hCond.iconPath,
          ));
        }
      } catch (_) {}
    }

    // Fallback hourly if API response was sparse
    if (hourlyList.isEmpty) {
      hourlyList.addAll(HourlyForecastData.mockHourlyList());
    }

    // 3. Daily Forecast (Hari Ini & Besok)
    final dailyList = <DailyForecastData>[];
    final dailyTimes = (dailyMap['time'] as List<dynamic>?)?.cast<String>() ?? [];
    final dailyMaxTemps = (dailyMap['temperature_2m_max'] as List<dynamic>?) ?? [];
    final dailyMinTemps = (dailyMap['temperature_2m_min'] as List<dynamic>?) ?? [];
    final dailyCodes = (dailyMap['weather_code'] as List<dynamic>?) ?? [];

    for (int i = 0; i < dailyTimes.length && i < 3; i++) {
      final maxT = (dailyMaxTemps[i] as num).toDouble();
      final minT = (dailyMinTemps[i] as num).toDouble();
      final dCode = (dailyCodes[i] as num).toInt();
      final dCond = WeatherIconMapper.mapCondition(dCode, isDay: true, temp: maxT);

      final label = i == 0 ? 'Hari Ini' : (i == 1 ? 'Besok' : 'Lusa');
      dailyList.add(DailyForecastData(
        dayLabel: label,
        tempMax: maxT,
        tempMin: minT,
        conditionText: dCond.description,
        iconPath: dCond.iconPath,
      ));
    }

    if (dailyList.isEmpty) {
      dailyList.addAll(DailyForecastData.mockDailyList());
    }

    return WeatherModel(
      locationName: locationName,
      date: DateTime.now(),
      current: currentData,
      hourly: hourlyList,
      daily: dailyList,
    );
  }

  /// Safe offline fallback data to ensure the UI never crashes or stays blank
  factory WeatherModel.mockFallback({String locationName = 'Menteng, Jakarta Pusat'}) {
    return WeatherModel(
      locationName: locationName,
      date: DateTime.now(),
      current: const CurrentWeatherData(
        temperature: 30.0,
        humidity: 92,
        weatherCode: 2,
        isDay: true,
        windSpeed: 11.5,
        aqi: 39.1,
        conditionText: 'Cerah Berawan',
        iconPath: 'lib/assets/images/icon_cuaca/cerah_mendung.png',
      ),
      hourly: HourlyForecastData.mockHourlyList(),
      daily: DailyForecastData.mockDailyList(),
    );
  }
}

class CurrentWeatherData {
  final double temperature;
  final int humidity;
  final int weatherCode;
  final bool isDay;
  final double windSpeed;
  final double aqi;
  final String conditionText;
  final String iconPath;

  const CurrentWeatherData({
    required this.temperature,
    required this.humidity,
    required this.weatherCode,
    required this.isDay,
    required this.windSpeed,
    required this.aqi,
    required this.conditionText,
    required this.iconPath,
  });

  String get aqiCategory {
    if (aqi <= 50) return 'Baik (Sehat)';
    if (aqi <= 100) return 'Sedang';
    if (aqi <= 150) return 'Tidak Sehat bagi Kelompok Sensitif';
    return 'Tidak Sehat';
  }
}

class HourlyForecastData {
  final String timeLabel;
  final double temperature;
  final int weatherCode;
  final String iconPath;

  const HourlyForecastData({
    required this.timeLabel,
    required this.temperature,
    required this.weatherCode,
    required this.iconPath,
  });

  static List<HourlyForecastData> mockHourlyList() {
    return const [
      HourlyForecastData(timeLabel: 'Sekarang', temperature: 30, weatherCode: 2, iconPath: 'lib/assets/images/icon_cuaca/berawan_biru.png'),
      HourlyForecastData(timeLabel: '10:00', temperature: 31, weatherCode: 1, iconPath: 'lib/assets/images/icon_cuaca/cerah.png'),
      HourlyForecastData(timeLabel: '13:00', temperature: 33, weatherCode: 0, iconPath: 'lib/assets/images/icon_cuaca/panas.png'),
      HourlyForecastData(timeLabel: '16:00', temperature: 31, weatherCode: 3, iconPath: 'lib/assets/images/icon_cuaca/cerah_mendung.png'),
      HourlyForecastData(timeLabel: '19:00', temperature: 28, weatherCode: 2, iconPath: 'lib/assets/images/icon_cuaca/malam_berawan.png'),
      HourlyForecastData(timeLabel: '22:00', temperature: 26, weatherCode: 1, iconPath: 'lib/assets/images/icon_cuaca/malam_cerah.png'),
    ];
  }
}

class DailyForecastData {
  final String dayLabel;
  final double tempMax;
  final double tempMin;
  final String conditionText;
  final String iconPath;

  const DailyForecastData({
    required this.dayLabel,
    required this.tempMax,
    required this.tempMin,
    required this.conditionText,
    required this.iconPath,
  });

  static List<DailyForecastData> mockDailyList() {
    return const [
      DailyForecastData(
        dayLabel: 'Hari Ini',
        tempMax: 32,
        tempMin: 24,
        conditionText: 'Cerah Berawan',
        iconPath: 'lib/assets/images/icon_cuaca/berawan_biru.png',
      ),
      DailyForecastData(
        dayLabel: 'Besok',
        tempMax: 30,
        tempMin: 23,
        conditionText: 'Hujan Ringan',
        iconPath: 'lib/assets/images/icon_cuaca/hujan.png',
      ),
    ];
  }
}

/// Helper mapping Open-Meteo WMO codes to Indonesian text and the 9 new asset icons
class WeatherIconMapper {
  WeatherIconMapper._();

  static ({String description, String iconPath}) mapCondition(
    int wmoCode, {
    bool isDay = true,
    double temp = 28,
  }) {
    // Night variants for clear & cloudy
    if (!isDay) {
      if (wmoCode == 0 || wmoCode == 1) {
        return (
          description: 'Malam Cerah',
          iconPath: 'lib/assets/images/icon_cuaca/malam_cerah.png',
        );
      }
      if (wmoCode == 2 || wmoCode == 3) {
        return (
          description: 'Malam Berawan',
          iconPath: 'lib/assets/images/icon_cuaca/malam_berawan.png',
        );
      }
    }

    // Day variants
    switch (wmoCode) {
      case 0: // Clear sky
        if (temp >= 33) {
          return (
            description: 'Cerah Terik',
            iconPath: 'lib/assets/images/icon_cuaca/panas.png',
          );
        }
        return (
          description: 'Cerah',
          iconPath: 'lib/assets/images/icon_cuaca/cerah.png',
        );

      case 1: // Mainly clear
        return (
          description: 'Cerah Sebagian',
          iconPath: 'lib/assets/images/icon_cuaca/cerah.png',
        );

      case 2: // Partly cloudy
        return (
          description: 'Cerah Berawan',
          iconPath: 'lib/assets/images/icon_cuaca/berawan_biru.png',
        );

      case 3: // Overcast
        return (
          description: 'Mendung',
          iconPath: 'lib/assets/images/icon_cuaca/mendung.png',
        );

      case 45:
      case 48: // Fog / rime fog
        return (
          description: 'Berkabut',
          iconPath: 'lib/assets/images/icon_cuaca/mendung.png',
        );

      case 51:
      case 53:
      case 55: // Drizzle
        return (
          description: 'Hujan Gerimis',
          iconPath: 'lib/assets/images/icon_cuaca/hujan.png',
        );

      case 61:
      case 63:
      case 65: // Rain slight/moderate/heavy
      case 80:
      case 81:
      case 82: // Rain showers
        return (
          description: 'Hujan',
          iconPath: 'lib/assets/images/icon_cuaca/hujan.png',
        );

      case 95:
      case 96:
      case 99: // Thunderstorm
        return (
          description: 'Hujan Petir',
          iconPath: 'lib/assets/images/icon_cuaca/hujan_petir.png',
        );

      default:
        return (
          description: 'Cerah Berawan',
          iconPath: 'lib/assets/images/icon_cuaca/cerah_mendung.png',
        );
    }
  }
}
