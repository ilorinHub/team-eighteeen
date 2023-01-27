import 'dart:io';

import 'package:intl/intl.dart';

class DateUtils{
  static String formatApiDate(String date) {
    var parseDate = HttpDate.parse(date);
    var formattedDate = DateFormat('EEE, MMM d, yyyy').format(parseDate);
    return formattedDate;
  }
}