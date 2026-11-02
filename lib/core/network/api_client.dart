import 'dart:convert';
import 'package:tugas_1/core/constants/api_constants.dart';

/// Custom Exception for network and API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

/// Abstract API client contract for Separation of Concerns.
/// When switching between HTTP or Dio, features won't need to change their calls.
abstract class BaseApiClient {
  Future<dynamic> get(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String endpoint, {Map<String, String>? headers, dynamic body});
  Future<dynamic> put(String endpoint, {Map<String, String>? headers, dynamic body});
  Future<dynamic> delete(String endpoint, {Map<String, String>? headers});
}

/// Ready-to-use template for API Client implementation
class ApiClient implements BaseApiClient {
  final String baseUrl;

  ApiClient({this.baseUrl = ApiConstants.baseApiUrl});

  @override
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    // Ready for http.get / dio.get implementation
    return null;
  }

  @override
  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    // Ready for http.post / dio.post implementation
    return null;
  }

  @override
  Future<dynamic> put(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    return null;
  }

  @override
  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    return null;
  }

  /// Helper to decode JSON response safely
  dynamic handleResponse(int statusCode, String responseBody) {
    if (statusCode >= 200 && statusCode < 300) {
      if (responseBody.isEmpty) return null;
      return jsonDecode(responseBody);
    } else {
      throw ApiException('Request failed with status: $statusCode', statusCode: statusCode);
    }
  }
}
