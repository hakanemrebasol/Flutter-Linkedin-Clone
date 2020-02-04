import 'package:flutter/material.dart';

class MyDatePicker {
  static Future<DateTime> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) return picked;
  }

  static DateTime convertStrToDatetime(String dateTime) {
    return DateTime.parse(dateTime);
  }
}
