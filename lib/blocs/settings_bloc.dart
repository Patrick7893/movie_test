import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:movies_test/models/settings.dart';
import 'package:movies_test/clients/shared_preferences_client.dart';

class SettingsBloc {
  SettingsBloc() {
    checkSharedPrefs();
    _settings.listen((settings) {
      _sharedPrefs.saveSettings(settings);
    });
  }

  final _sharedPrefs = SharedPrefecrencesClient();
  final _settings = BehaviorSubject<Settings>();

  Function(bool) get setNotifications => (value) {
        final settings = _settings.value;
        settings.notifications = value;
        _settings.add(settings);
      };

  Function(NotificationsTimeRange) get setNotificationsTimeRange => (value) {
        final settings = _settings.value;
        settings.notificationsTimeRange = value;
        _settings.add(settings);
      };

  Stream<Settings> get settings => _settings.stream;

  Future checkSharedPrefs() async {
    final settings = await _sharedPrefs.getSettings();
    if (settings != null) {
      _settings.add(settings);
    } else {
      _settings.add(Settings());
    }
  }

  void dispose() {
    _settings.close();
  }
}
