import 'dart:convert';

import 'package:flutter/services.dart';

Future<String> getUrlFromConfigFile(String chaveConfig) async {
  final configString = await rootBundle.loadString('assets/config/config.json');
  final configJson = jsonDecode(configString);
  return configJson[chaveConfig];
}
