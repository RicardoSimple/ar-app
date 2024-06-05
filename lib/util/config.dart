import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Config {
  final String baseUrl;

  Config({required this.baseUrl});

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      baseUrl: json['baseUrl'],
    );
  }
}

class ConfigService {
  static Config? _config;

  static Future<Config> loadConfig() async {
    if (_config == null) {
      final String configString = await rootBundle.loadString('assets/config.json');
      final Map<String, dynamic> configJson = json.decode(configString);
      _config = Config.fromJson(configJson);
    }
    return _config!;
  }
}
