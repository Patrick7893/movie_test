import 'package:flutter/material.dart';
import 'package:movies_test/models/settings.dart';
import 'package:movies_test/blocs/bloc_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: StreamBuilder<Settings>(
          stream: BlocProvider.instance.settingsBloc.settings,
          builder: (context, snapshot) {
            final settings = snapshot.data;
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _notificationsCheckBox(settings?.notifications ?? false),
                  SizedBox(height: 8.0),
                  _notificationsTimeRange(settings?.notificationsTimeRange ??
                      NotificationsTimeRange.one_week)
                ],
              ),
            );
          },
        ));
  }

  Widget _notificationsCheckBox(bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Notifications'),
        Checkbox(
          value: value,
          onChanged: BlocProvider.instance.settingsBloc.setNotifications,
        )
      ],
    );
  }

  Widget _notificationsTimeRange(NotificationsTimeRange value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Time range'),
        DropdownButton<NotificationsTimeRange>(
          value: value,
          onChanged:
              BlocProvider.instance.settingsBloc.setNotificationsTimeRange,
          items: NotificationsTimeRange.values
              .map<DropdownMenuItem<NotificationsTimeRange>>(
                  (NotificationsTimeRange value) {
            String timeRangeString;
            switch (value) {
              case NotificationsTimeRange.one_week:
                timeRangeString = 'One week';
                break;
              case NotificationsTimeRange.three_days:
                timeRangeString = 'Three days';
                break;
              case NotificationsTimeRange.one_day:
                timeRangeString = 'One day';
                break;
            }
            return DropdownMenuItem<NotificationsTimeRange>(
              value: value,
              child: Text(timeRangeString),
            );
          }).toList(),
        ),
      ],
    );
  }
}
