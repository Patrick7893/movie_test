import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:movies_test/models/movie.dart';
import 'package:movies_test/clients/moviedb_client.dart';

class MoviesBloc {
  final _client = MoviedbClient();

  final _movies = BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get movies => _movies.stream;

  Future getUpcomingMovies() async {
    final movies = await _client.getUpcomingMovies(10);
    _movies.add(movies);
  }
}
