import 'dart:convert';

import 'package:flutter/services.dart';

class JsonReader {
  static Future<List> readStatistic() async {
    final json = await rootBundle.loadString("assets/data/statistic.json");
    final data = await jsonDecode(json);
    return data;
  }
}
