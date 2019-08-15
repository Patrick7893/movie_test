class Movie {
  int id = 0;
  String title = '';
  double popularity = 0;
  DateTime releaseDate = DateTime.fromMillisecondsSinceEpoch(0);
  String overview = '';
  String posterUrl = '';
  String backdropUrl = '';

  Movie.fromJson(dynamic map, String baseImageUrl) {
    id = map['id'];
    title = map['title'] ?? '';
    popularity = map['popularity'] ?? '';
    final dateString = map['release_date'] ?? '';
    releaseDate = DateTime.parse(dateString);
    overview = map['overview'] ?? '';
    final String posterPath = map['poster_path'];
    final String backdropPath = map['backdrop_path'];
    if (posterPath?.isNotEmpty == true) {
      posterUrl = baseImageUrl + posterPath;
    }
    if (backdropPath?.isNotEmpty == true) {
      backdropUrl = baseImageUrl + backdropPath;
    }
  }
}
