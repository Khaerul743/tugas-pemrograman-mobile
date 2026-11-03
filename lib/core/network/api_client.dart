import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
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
abstract class BaseApiClient {
  Future<dynamic> get(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String endpoint, {Map<String, String>? headers, dynamic body});
  Future<dynamic> put(String endpoint, {Map<String, String>? headers, dynamic body});
  Future<dynamic> delete(String endpoint, {Map<String, String>? headers});
}

/// Production-ready HTTP Client implementation
class ApiClient implements BaseApiClient {
  final String baseUrl;
  final http.Client _client;

  ApiClient({
    this.baseUrl = ApiConstants.baseApiUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  Uri _buildUri(String endpoint, [Map<String, dynamic>? queryParameters]) {
    final cleanEndpoint = endpoint.startsWith('/') ? endpoint : '/$endpoint';
    final fullUrl = endpoint.startsWith('http') ? endpoint : '$baseUrl$cleanEndpoint';
    final parsed = Uri.parse(fullUrl);

    if (queryParameters != null && queryParameters.isNotEmpty) {
      final stringParams = queryParameters.map((k, v) => MapEntry(k, v.toString()));
      return parsed.replace(queryParameters: {
        ...parsed.queryParameters,
        ...stringParams,
      });
    }
    return parsed;
  }

  @override
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client.get(
        uri,
        headers: headers,
      ).timeout(ApiConstants.connectTimeout);

      return handleResponse(response.statusCode, response.body);
    } on SocketException catch (e) {
      throw ApiException('Tidak dapat terhubung ke server (Offline): ${e.message}');
    } on TimeoutException {
      throw ApiException('Koneksi waktu habis (Timeout)');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Terjadi kesalahan jaringan: $e');
    }
  }

  @override
  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      final response = await _client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
        body: body is Map || body is List ? jsonEncode(body) : body,
      ).timeout(ApiConstants.connectTimeout);

      return handleResponse(response.statusCode, response.body);
    } on SocketException catch (e) {
      throw ApiException('Tidak dapat terhubung ke server (Offline): ${e.message}');
    } on TimeoutException {
      throw ApiException('Koneksi waktu habis (Timeout)');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Terjadi kesalahan jaringan: $e');
    }
  }

  @override
  Future<dynamic> put(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      final response = await _client.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
        body: body is Map || body is List ? jsonEncode(body) : body,
      ).timeout(ApiConstants.connectTimeout);

      return handleResponse(response.statusCode, response.body);
    } on SocketException catch (e) {
      throw ApiException('Tidak dapat terhubung ke server: ${e.message}');
    } on TimeoutException {
      throw ApiException('Koneksi waktu habis (Timeout)');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Terjadi kesalahan jaringan: $e');
    }
  }

  @override
  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      final response = await _client.delete(
        uri,
        headers: headers,
      ).timeout(ApiConstants.connectTimeout);

      return handleResponse(response.statusCode, response.body);
    } on SocketException catch (e) {
      throw ApiException('Tidak dapat terhubung ke server: ${e.message}');
    } on TimeoutException {
      throw ApiException('Koneksi waktu habis (Timeout)');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Terjadi kesalahan jaringan: $e');
    }
  }

  /// Helper to decode JSON response safely
  dynamic handleResponse(int statusCode, String responseBody) {
    if (statusCode >= 200 && statusCode < 300) {
      if (responseBody.isEmpty) return null;
      return jsonDecode(responseBody);
    } else {
      throw ApiException('Request gagal dengan status: $statusCode', statusCode: statusCode);
    }
  }
}
