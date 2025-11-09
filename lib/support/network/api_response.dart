import 'package:image_app/support/enums/e_error_code.dart';

/// Generic response container for handling data, success status, and HTTP status code.
class ApiResponse<T> {
  final T? data;
  final bool isSuccess;
  final int statusCode;
  final ErrorCode? errorCode;
  final String? message;

  ApiResponse(this.data, this.isSuccess, this.statusCode,
      {this.errorCode, this.message});

  // Factory constructor for success responses
  factory ApiResponse.success(T? data, int statusCode, {String? message}) {
    return ApiResponse(data, true, statusCode, message: message);
  }

  // Factory constructor for failure responses
  factory ApiResponse.failure(
      int statusCode, ErrorCode errorCode, String message) {
    return ApiResponse(
      null,
      false,
      statusCode,
      errorCode: errorCode,
      message: message.isEmpty ? _getErrorMessage(errorCode) : message,
    );
  }

  // Private method to map ErrorCode to error messages
  static String _getErrorMessage(ErrorCode errorCode) {
    switch (errorCode) {
      case ErrorCode.unsupportedMethod:
        return 'The requested method is not supported.';
      case ErrorCode.networkTimeout:
        return 'The network request timed out.';
      case ErrorCode.networkError:
        return 'A network error occurred. Please check your connection.';
      case ErrorCode.clientError:
        return 'A client-side error occurred.';
      case ErrorCode.serverError:
        return 'A server-side error occurred. Please try again later.';
      case ErrorCode.cacheError:
        return 'An error occurred while accessing cached data.';
      case ErrorCode.tokenExpired:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
