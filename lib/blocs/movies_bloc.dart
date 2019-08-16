import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:movies_test/models/movie.dart';
import 'package:movies_test/models/settings.dart';
import 'package:movies_test/clients/moviedb_client.dart';
import 'package:movies_test/utils/notifications.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class MoviesBloc {
  MoviesBloc() {
    settingsAndMoviesCombined.listen((Map combinedMap) {
      final Settings settings = combinedMap['settings'];
      final List<Movie> movies = combinedMap['movies'];
      if (settings.notifications) {
        movies.forEach((movie) {
          _scheduleNotification(
              movie, settings.notificationsTimeRangeInSeconds);
        });
      } else {
        Notifications.instance.cancelNotifications();
      }
    });
  }
  final _client = MoviedbClient();

  final _movies = BehaviorSubject<List<Movie>>();
  final _settings = BehaviorSubject<Settings>();

  StreamSink<Settings> get settingsSink => _settings.sink;

  Stream<List<Movie>> get movies => _movies.stream;

  Stream<Map> get settingsAndMoviesCombined =>
      Observable.combineLatest2(movies, _settings, (movies, settings) {
        return {'movies': movies, 'settings': settings};
      });

  Future getUpcomingMovies() async {
    final movies = await _client.getUpcomingMovies(1);
    _movies.add(movies);
  }

  void _scheduleNotification(Movie movie, int timeRange) {
    final scheduledDateTime =
        movie.releaseDate.subtract(Duration(seconds: timeRange));
    // final scheduledDateTime = DateTime.now().add(Duration(seconds: 5));
    Notifications.instance.scheduleNotification(
        movie.id,
        scheduledDateTime,
        movie.title,
        DateFormat('yyyy-MM-dd').format(movie.releaseDate),
        json.encode(movie.toJson()));
  }

  void dispose() {
    _settings.close();
    _movies.close();
  }
}
