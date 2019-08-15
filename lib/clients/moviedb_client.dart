import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:movies_test/models/movie.dart';

class MoviedbClient {
  final Client httpClient = Client();
  final String _endpoint = 'https://api.themoviedb.org/3';
  final String _apiKey = '7d339b5e64b50deb4074420646a1b3e1';
  final String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  Future<List<Movie>> getUpcomingMovies(int count) async {
    try {
      final response = await httpClient.get(_endpoint +
          '/movie/upcoming?api_key=$_apiKey&language=en-US&page=$count');
      final List<dynamic> decodedList = json.decode(response.body)['results'];
      final movies = decodedList
          .map((movieJson) => Movie.fromJson(movieJson, _imageBaseUrl))
          .toList();
      return movies;
    } catch (e) {
      print('Error while requesting moveis $e');
      return null;
    }
  }
}
