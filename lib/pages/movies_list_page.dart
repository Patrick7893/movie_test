import 'package:flutter/material.dart';
import 'package:movies_test/blocs/bloc_provider.dart';
import 'package:movies_test/models/movie.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_test/pages/movie_details_page.dart';
import 'package:movies_test/pages/settings_page.dart';
import 'package:movies_test/utils/notifications.dart';

class MoviesListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  @override
  void initState() {
    BlocProvider.instance.moviesBloc.getUpcomingMovies();
    Notifications.instance.init((payload) {
      final movie = Movie.fromJson(json.decode(payload), false);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MovieDetailsPage(
                movie: movie,
              )));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming movies'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          )
        ],
      ),
      body: StreamBuilder<List<Movie>>(
        stream: BlocProvider.instance.moviesBloc.movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final movies = snapshot.data;
            return GridView.builder(
              itemCount: movies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0),
              itemBuilder: (context, index) => MovieCard(
                movie: movies[index],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({@required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MovieDetailsPage(
                  movie: movie,
                )));
      },
      child: Card(
        child: movie.posterUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: movie.posterUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              )
            : Container(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.help_outline,
                        size: 64.0,
                        color: Colors.grey[700],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          movie.title,
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
