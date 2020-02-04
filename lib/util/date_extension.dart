import 'package:date_format/date_format.dart';

convertDateToFormat(DateTime date, List<String> format) {
  return formatDate(date, format);
}

DateTime convertStrToDatetime(String dateTime) {
  return DateTime.parse(dateTime);
}

var ddMMyyyyFormat = [dd, ' ', MM, ' ', yyyy];
var MMyyyyFormat = [MM, ' ', yyyy];
var yyyyFormat = [yyyy];
