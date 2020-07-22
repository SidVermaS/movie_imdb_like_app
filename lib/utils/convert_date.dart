import 'package:intl/intl.dart';

class ConvertDate {

  String convertToMMMMMddyyyy(String dateTimeString)  {
    DateTime dateTime=DateFormat('yyyy-MM-dd').parse(dateTimeString);
    dateTimeString=DateFormat('MMMM dd, yyyy').format(dateTime);
    return dateTimeString;
  }











}