
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:news_flutter_app/model/table_enum.dart';

class Utils {

  static List<String> getMasterTable() {
    List<String> tableList = [];
    for (int i = 0; i < TableEnum.values.length; i++) {
        tableList.add(describeEnum(TableEnum.values[i].toString()));
    }
    return tableList;
  }

  static String? getFormatedDate(String? dateTime) {
    if (dateTime == null) return null;
    String? formatted;
    try {
      DateTime parseDate =
      new DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(dateTime);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('yyyy-MM-dd');
      formatted = outputFormat.format(inputDate);
    } catch (e) {
      print(e);
    }
    return formatted;
  }

}
