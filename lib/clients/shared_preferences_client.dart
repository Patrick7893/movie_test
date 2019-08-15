import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies_test/models/settings.dart';
import 'dart:convert';

class SharedPrefecrencesClient {
  Future<bool> saveSettings(Settings settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('settings', json.encode(settings.toJson()));
    return true;
  }

  Future<Settings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final settignsString = prefs.getString('settings');
    if (settignsString?.isNotEmpty != null) {
      final settignsJson = json.decode(settignsString);
      return Settings.fromJson(settignsJson);
    } else {
      return null;
    }
  }
}
