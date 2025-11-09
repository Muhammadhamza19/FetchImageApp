import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class AppUtils {
  // Future<bool> isConnectedToNetwork() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     return true;
  //   }

  //   showErrorMessage("Connection not found");
  //   return false;
  // }

  bool isValidEmail(String email) {
    // Define the regular expression for validating an email
    final RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{1,}$");

    // Check if the email matches the regex
    return emailRegex.hasMatch(email);
  }

  static String getCompleteImageUrl(String imageName) {
    final String replaceImageName =
        imageName.replaceAll('images/', 'ProdImages/');

    return replaceImageName;
  }

  String totalDaysLeft({String? endDateStr, String? currentDateStr}) {
    final DateTime endDate = DateTime.parse(endDateStr ?? "");
    final DateTime currentDate = DateTime.parse(currentDateStr ?? "");
    final Duration difference = endDate.difference(currentDate);

    // Get the number of days left
    final int daysLeft = difference.inDays;
    return "$daysLeft days left";
  }

  String formatDate(String date) {
    try {
      // Parse the input date string
      final DateTime parsedDate = DateTime.parse(date);

      // Format the date to 'dd-MM-yyyy'
      final String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);

      return formattedDate;
    } catch (e) {
      // If parsing fails, return an error message or default value
      return 'Invalid Date';
    }
  }

  String getGreeting() {
    // Get current time
    final int currentHour = DateTime.now().hour;

    // Determine the greeting based on the hour
    if (currentHour >= 5 && currentHour < 12) {
      return 'Good Morning!';
    } else if (currentHour >= 12 && currentHour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  String replacePlusWithPercent2B(String input) {
    return input.replaceAll('+', '%2b');
  }

  IconData getWeatherIcon(String? status) {
    switch (status?.toLowerCase()) {
      case 'sunny':
      case 'clear':
        return Icons.wb_sunny_outlined;
      case 'cloudy':
      case 'overcast':
        return Icons.wb_cloudy_outlined;
      case 'rain':
      case 'rainy':
      case 'drizzle':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'fog':
      case 'mist':
      case 'haze':
        return Icons.blur_on;
      default:
        return Icons.wb_sunny_outlined; // Fallback icon
    }
  }
}

extension StringEncryption on String {
  static final _key = encrypt.Key.fromUtf8(
      '12345678901234567890123456789012'); // 16/24/32 chars
  static final _iv = encrypt.IV.fromUtf8('1234567890123456');

  String encryptString() {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    final encrypted = encrypter.encrypt(this, iv: _iv);
    return encrypted.base64;
  }

  String decryptString() {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    return encrypter.decrypt64(this, iv: _iv);
  }

  String encryptPrefixes() {
    if (isEmpty) return "";

    final encryptedPrefixes = <String>[];
    for (int i = 1; i <= length; i++) {
      final prefix = substring(0, i);
      encryptedPrefixes.add(prefix.encryptString());
    }
    return encryptedPrefixes.join(",");
  }
}
