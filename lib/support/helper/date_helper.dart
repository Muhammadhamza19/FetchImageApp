import 'package:intl/intl.dart';

const String _dateFormat = 'dd/MM/y';
const String _timeFormat = 'HH:mm';
const String altDateFormat = 'dd-MM-y HH:mm:ss';

/// If we need to change the format of dates, do it all here...
/// Eventually we'll need to use the user preferences for date and time formats
/// @applyTimezone - not used atm
String formatDateTime(
  dynamic dateTime, {
  bool dateOnly = false,
  bool timeOnly = false,
  bool? yearOnly = false,
  String? format,
  bool applyTimezone = true,
}) {
//  print('Format DateTime - ${dateTime.toString()}');
  if (dateTime == null) {
    // In theory, you'd only ever want to format an actual value so instead of nulling it
    // return ''.  That way we gracefully know it was null and can stop the parsing
    return '';
  }
  if (yearOnly == true) {
    return _format(dateTime, format ?? 'y', applyTimezone);
  }
  if (dateOnly) {
    return _format(dateTime, format ?? _dateFormat, applyTimezone);
  }
  if (timeOnly) {
    return _format(dateTime, format ?? _timeFormat, applyTimezone);
  }

  /// Date and time
  return _format(
      dateTime, format ?? '$_dateFormat $_timeFormat', applyTimezone);
}

String _format(dynamic dateTime, String dateFormat, bool applyTimezone) {
  if (dateTime is DateTime) {
    return DateFormat(dateFormat)
        .format(applyTimezone == true ? dateTime.toLocal() : dateTime);
  } else if (dateTime is String) {
    if (dateTime.isEmpty) return '';
    try {
      return DateFormat(dateFormat).format(applyTimezone == true
          ? DateTime.parse(dateTime).toLocal()
          : DateTime.parse(dateTime));
    } catch (ex) {
      if (ex is FormatException) {
        return 'Invalid date format';
      } else {
        rethrow;
      }
    }
  } else {
    print('DateHelper - Could not parse dateTime');
    return '';
  }
}

DateTime? convertToDateTime(String? date, {String? format, bool utc = false}) {
  if (date == null) return null;
  format ??= '$_dateFormat $_timeFormat';
  return DateFormat(format).parse(date, utc);
}

///We'll apply 'Z' if it doesn't exist so we can apply the correct timezone times in the UI
String normaliseApiDateTime(String dateTime) {
  dateTime = applyTimeZoneFormat(dateTime);
  return dateTime;
}

/// toIso8601String = "$y-$m-${d}T$h:$min:$sec.$ms${us}Z"
/// APIDateFormat (RAP expected) = "DD-MM-YYYY HH:mm:ss" - doesn't want millis
String toApiDateString(DateTime dateTime) {
  String isoDate = dateTime.toIso8601String();
  if (isoDate.contains('.')) {
    // we have millis to get rid of
    final split = isoDate.split('.');
    isoDate = split[0];
    if (split[1].contains('Z')) {
      isoDate = '${isoDate}Z';
    }
  }
  return isoDate;
}

/// There are many inconsistencies with RapCore dateTimes.  Although this seems sketchy we literally
/// chuck on a Z on every dateTime we serialise from the api (as it sends as UTC but without the "Z").
/// Without this the app will never know whether it should apply a TimeZone in the front end to the local TimeZone
/// Z basically lets us know it's actually UTC, so we need to apply the TimeZone
/// If we use DateTime "toUTC()" it will apply the timezone ("Z") but also change the time to match.
String applyTimeZoneFormat(String dateTime) {
  // print('Pre-Check for timezone - $dateTime');
  String? time;
  if (dateTime.contains('T')) {
    // for 2019-09-19T08:00:00 format
    time = dateTime.split('T')[1];
  } else if (dateTime.contains(' ')) {
    // for 2019-09-19 08:00:00 format
    time = dateTime.split(' ')[1];
  }
  // check it exists and looks like a time
  if (time != null && time.contains(':')) {
    if (!time.contains('Z') && !time.contains('+') && !time.contains('-')) {
      dateTime = '${dateTime}Z';
    }
  }
  // print('Post-Check for timezone - $dateTime');
  return dateTime;
}

String removeTimeZone(String dateTime) {
  if (dateTime.contains('Z')) {
    final split = dateTime.split('Z');
    dateTime = split[0];
  }
  return dateTime;
}

/// For date only
bool isSameDate(DateTime date1, DateTime date2) =>
    date1.year == date2.year &&
    date1.month == date2.month &&
    date1.day == date2.day;

/// Instead of using network call, we calculate it ourselves.  Means offline can use this too.
List<DateTime> calculateValidityTimes(
    {required DateTime dateTime, int? maxValidity}) {
  maxValidity ??= 24;
  final dates = <DateTime>[];
  DateTime next;
  final minutesToNextHour = 60 - dateTime.minute;
  if (minutesToNextHour > 30) {
    // it's next half hour needed
    next = DateTime(
        dateTime.year, dateTime.month, dateTime.day, dateTime.hour, 30);
  } else {
    // it's next hour needed
    next = DateTime(
        dateTime.year, dateTime.month, dateTime.day, dateTime.hour + 1);
  }
  dates.add(next);
  // max validity is hours, we use half hour times, so times it by 2 to get each half hour (2 hours would be 4 half hours!)
  for (var i = 1; i < maxValidity * 2; i++) {
    next = next.add(const Duration(minutes: 30));
    dates.add(next);
  }
  return dates;
}

/// Handy to use as a simplified/normal date parsing method instead of DateTimeConverter which
/// messes around with the datetime.  Notably used for token expiry date to keep the values the same
DateTime parseDateTime(String json) => DateTime.parse(json);

int get hoursDiff {
  final DateTime localDate = DateTime.now().toLocal();
  final DateTime utcDate = DateTime.now().toUtc();
  final int hourDiff = localDate.hour - utcDate.hour;

  return hourDiff;
}

DateTime endOfDay(DateTime date) {
  final nextDay = DateTime(date.year, date.month, date.day + 1);
  return nextDay.subtract(const Duration(seconds: 1));
}

DateTime beginningOfDay(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

String howLongAgo(DateTime? date) {
  if (date == null) return '';
  final diff = DateTime.now().difference(date);
  if (diff.inDays > 0) {
    return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
  }
  if (diff.inHours > 0) {
    return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
  }
  if (diff.inMinutes > 0) {
    return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
  }
  return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
}
