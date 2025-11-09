import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:image_app/support/config/app_config.dart';
import 'package:image_app/support/config/app_shared_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_app/support/enums/e_error_code.dart';
import 'package:image_app/support/enums/e_http_method.dart';
import 'package:image_app/support/network/api_response.dart';

class BaseProvider {
  Duration requestTimeout = const Duration(minutes: 2);

  String get baseUrl => AppSharedPref.getBaseUrl() ?? AppConfig().baseUrl;

  // ANSI color codes
  String reset = '\x1B[0m';
  String red = '\x1B[31m';
  String green = '\x1B[32m';
  String yellow = '\x1B[33m';
  String blue = '\x1B[34m';
  String cyan = '\x1B[36m';
  String magenta = '\x1B[35m';
  String _timestamp() {
    final now = DateTime.now();
    return now.toIso8601String();
  }

  Future<ApiResponse<T>> execute<T>({
    required String endpoint,
    HttpMethod method = HttpMethod.get,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    String? pathParameter,
    String? baseUrlOverride,
    Function(dynamic)? toCache,
    T Function(dynamic)? parser,
    Future<T> Function()? fromCache,
    String? contentType,
    String? token,
    String? signature,
    bool snapShot = false,
// Added to handle file uploads
  }) async {
    String url = (baseUrlOverride ?? baseUrl) + endpoint;
    if (pathParameter != null) {
      url += '/$pathParameter';
    }
    final combinedQueryParams = {
      if (queryParameters != null) ...queryParameters,
    };

    final uri = Uri.parse(url).replace(queryParameters: combinedQueryParams);

    if (kDebugMode) {
      debugPrint("URI ${uri.toString()}");
    }

    final Map<String, String> headers = {
      // Content-Type will be set for JSON or omitted for multipart (handled by MultipartRequest)
      if (contentType != 'multipart/form-data')
        'Content-Type': contentType ?? 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    if (signature != null) {
      headers['X-Signature'] = signature;
    }

    try {
      http.Response response;

      if (contentType == 'multipart/form-data') {
        // Handle multipart/form-data request
        final request = http.MultipartRequest(method.name.toUpperCase(), uri);

        // Add headers
        request.headers.addAll(headers);

        // Add fields from body (if any)
        if (body != null && body is Map<String, dynamic>) {
          body.forEach((key, value) {
            request.fields[key] = value.toString();
          });
        }

        // Add files from attachments

        // Send the multipart request
        final streamedResponse = await request.send().timeout(requestTimeout);
        response = await http.Response.fromStream(streamedResponse);
      } else {
        // Handle JSON-based request
        final String? bodyString = body != null ? jsonEncode(body) : null;

        if (kDebugMode) {
          debugPrint("""
$blue━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🕒 ${_timestamp()}
🌐 REQUEST URI: ${uri.toString()}
➡️ [HTTP ${method.name.toUpperCase()}]
📤 BODY:
${bodyString ?? "null"}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$reset
""");
        }
        switch (method) {
          case HttpMethod.get:
            if (bodyString != null) {
              final request = http.Request('GET', uri)
                ..headers.addAll(headers)
                ..body = bodyString;

              final streamedResponse = await request.send();
              response = await http.Response.fromStream(streamedResponse);
            } else {
              response = await http
                  .get(
                    uri,
                    headers: headers,
                  )
                  .timeout(requestTimeout);
            }

            break;
          case HttpMethod.delete:
            response = await http
                .delete(uri, headers: headers, body: bodyString)
                .timeout(requestTimeout);
            break;
          case HttpMethod.post:
            response = await http
                .post(
                  uri,
                  headers: headers,
                  body: bodyString,
                )
                .timeout(requestTimeout);
            break;
          case HttpMethod.put:
            response = await http
                .put(
                  uri,
                  headers: headers,
                  body: bodyString,
                )
                .timeout(requestTimeout);
            break;
        }
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseBody = jsonDecode(response.body);
        if (kDebugMode) {
          debugPrint("""
$green━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🕒 ${_timestamp()}

url $uri
📥 RESPONSE CODE: ${response.statusCode}
✅ SUCCESS
${responseBody.toString()}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$reset
""");
        }
        if (toCache != null) {
          toCache(responseBody);
        }
        final T result =
            parser != null ? parser(responseBody) : responseBody as T;
        return ApiResponse.success(
          result,
          response.statusCode,
          message: responseBody['message']?.toString() ?? '',
        );
      } else {
        String errorMessage = '';
        ErrorCode errorCode;

        try {
          final decodedBody = jsonDecode(response.body);
          errorMessage = decodedBody['message']?.toString() ?? '';
        } catch (e) {
          errorMessage = response.body.isNotEmpty
              ? response.body
              : 'Internal Server Error';
        }

        if (response.statusCode == 500 &&
            errorMessage.toLowerCase().contains('jwt expired')) {
          errorCode = ErrorCode.tokenExpired;
        } else {
          errorCode = response.statusCode >= 500
              ? ErrorCode.serverError
              : ErrorCode.clientError;
        }

        return ApiResponse.failure(
          response.statusCode,
          errorCode,
          errorMessage,
        );
      }
    } on SocketException {
      const ErrorCode errorCode = ErrorCode.networkError;

      if (fromCache != null) {
        try {
          final T? cachedData = await fromCache();
          if (cachedData != null) {
            return ApiResponse.success(cachedData, 200);
          }
        } catch (cacheError) {
          debugPrint('Cache retrieval error: $cacheError');
        }
      }

      if (snapShot) {
        await saveRequestSnapshot(
          url: url,
          method: method.name,
          headers: headers,
          body: body,
          queryParams: queryParameters,
          pathParam: pathParameter,
          timestamp: DateTime.now(),
        );
        return ApiResponse.success(null, 200);
      }

      return ApiResponse.failure(400, errorCode, "");
    } catch (e) {
      debugPrint('Request exception: $e');
      const ErrorCode errorCode = ErrorCode.tokenExpired;

      if (fromCache != null) {
        try {
          final T? cachedData = await fromCache();
          if (cachedData != null) {
            return ApiResponse.success(cachedData, 200);
          }
        } catch (cacheError) {
          debugPrint('Cache retrieval error: $cacheError');
        }
      }

      return ApiResponse.failure(400, errorCode, "");
    }
  }

  Future<void> toCache(String key, dynamic data) async {
    final box = await Hive.openBox('newsbox');
    try {
      final String jsonData = json.encode(data);
      await box.put(key, jsonData);
      debugPrint('Data cached successfully for key $key');
    } catch (e) {
      debugPrint('Failed to cache data: $e');
    }
  }

  Future<T> fromCache<T>(String key, T Function(dynamic) fromJson) async {
    final box = Hive.box('newsbox');
    try {
      final String? jsonData = box.get(key);
      if (jsonData != null) {
        return fromJson(json.decode(jsonData));
      } else {
        throw Exception('No data found in cache for key: $key');
      }
    } catch (e) {
      debugPrint('Failed to retrieve data from cache: $e');
      throw Exception('Error retrieving data from cache: $e');
    }
  }

  Future<void> saveRequestSnapshot({
    required String url,
    required String method,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    String? pathParam,
    required DateTime timestamp,
  }) async {
    final box = Hive.box('requestBox');
    final requestSnapshot = {
      'url': url,
      'method': method,
      'headers': headers,
      'body': body,
      'queryParams': queryParams,
      'pathParam': pathParam,
      'timestamp': timestamp.toString(),
    };
    await box.add(requestSnapshot);
  }

  Future<void> syncRequests() async {
    final box = Hive.box('requestBox');
    final List<dynamic> requests = box.values.toList();

    for (final request in requests) {
      try {
        await execute(
          endpoint: request['url'],
          method: request['method'] == 'HttpMethod.get'
              ? HttpMethod.get
              : HttpMethod.post,
          body: request['body'],
          queryParameters: request()['queryParams'],
          pathParameter: request['pathParam'],
        );

        await box.deleteAt(box.keyAt(request));
      } catch (e) {
        debugPrint('Failed to sync request: $e');
      }
    }
  }
}
