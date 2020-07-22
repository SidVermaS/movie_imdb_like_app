import 'package:intl/intl.dart';

class ConvertDate {

  String convertToMddyyyy(String dateTimeString)  {
    DateTime dateTime=DateFormat('yyyy-mm-dd').parse(dateTimeString);
    dateTimeString=DateFormat('M dd, yyyy').format(dateTime);
    return dateTimeString;
  }











}