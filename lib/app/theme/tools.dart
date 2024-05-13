/*
  This file contains a utility class for date formatting.
*/

import 'package:intl/intl.dart';

class Tools {
  // Method to format DateTime object to 'dd/MM/yyyy' format
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(date);
    return formattedDate;
  }
}
