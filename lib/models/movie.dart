import 'package:intl/intl.dart';

class Movie {
  int id = 0;
  String title = '';
  double popularity = 0;
  DateTime releaseDate = DateTime.fromMillisecondsSinceEpoch(0);
  String overview = '';
  String posterUrl = '';
  String backdropUrl = '';

  Movie.fromJson(dynamic map, bool isFromNetwok) {
    id = map['id'];
    title = map['title'] ?? '';
    popularity = map['popularity'] ?? '';
    final dateString = map['release_date'] ?? '';
    releaseDate = DateTime.parse(dateString);
    overview = map['overview'] ?? '';
    posterUrl = map['poster_path'] ?? '';
    backdropUrl = map['backdrop_path'] ?? '';
    if (isFromNetwok && posterUrl?.isNotEmpty == true) {
      posterUrl = 'https://image.tmdb.org/t/p/w500' + posterUrl;
    }
    if (isFromNetwok && backdropUrl?.isNotEmpty == true) {
      backdropUrl = 'https://image.tmdb.org/t/p/w500' + backdropUrl;
    }
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'popularity': popularity,
      'release_date': DateFormat('yyyy-MM-dd').format(releaseDate),
      'overview': overview,
      'poster_path': posterUrl,
      'backdrop_path': backdropUrl
    };
  }
}
