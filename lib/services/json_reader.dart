import 'dart:convert';

import 'package:flutter/services.dart';

class JsonReader {
  static Future<List> readStatistic() async {
    final json = await rootBundle.loadString("assets/data/statistic.json");
    final data = await jsonDecode(json);
    return data;
  }

  static Future<List> readSkills() async {
    final json = await rootBundle.loadString("assets/data/skills.json");
    final data = await jsonDecode(json);
    return data;
  }
}
