import 'package:flutter/material.dart';
import 'package:movies_test/models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({@required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    print(movie.backdropUrl);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          Container(
              height: 250.0,
              child: Stack(
                children: <Widget>[
                  movie.backdropUrl.isNotEmpty
                      ? Opacity(
                          opacity: 0.3,
                          child: CachedNetworkImage(
                            imageUrl: movie.backdropUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(movie.title,
                              style: Theme.of(context).textTheme.title),
                          SizedBox(height: 8.0),
                          Text(DateFormat('yyyy-MM-dd')
                              .format(movie.releaseDate)),
                          SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  )
                ],
              )),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 16.0),
                Text('OVERVIEW',
                    style: TextStyle(fontSize: 16.0, color: Colors.teal)),
                SizedBox(height: 8.0),
                Text(movie.overview)
              ],
            ),
          )
        ],
      ),
    );
  }
}
