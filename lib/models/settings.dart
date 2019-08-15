class Settings {
  bool notifications = true;
  NotificationsTimeRange notificationsTimeRange =
      NotificationsTimeRange.one_week;
  int notificationsTimeRangeInSeconds = 0;

  Settings();

  Settings.fromJson(dynamic map) {
    notifications = map['notifications'];
    notificationsTimeRange =
        NotificationsTimeRange.values[map['notificationsTimeRange']];
    switch (notificationsTimeRange) {
      case NotificationsTimeRange.one_week:
        {
          notificationsTimeRangeInSeconds = 60 * 60 * 24 * 7;
          break;
        }
      case NotificationsTimeRange.three_days:
        notificationsTimeRangeInSeconds = 60 * 60 * 24 * 3;
        break;
      case NotificationsTimeRange.one_day:
        notificationsTimeRangeInSeconds = 60 * 60 * 24;
        break;
    }
  }

  Map toJson() {
    return {
      'notifications': notifications,
      'notificationsTimeRange': notificationsTimeRange.index
    };
  }
}

enum NotificationsTimeRange { one_week, three_days, one_day }
