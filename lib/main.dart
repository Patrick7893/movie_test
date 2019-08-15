import 'package:flutter/material.dart';
import 'package:movies_test/pages/movies_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Avenir'),
      home: MoviesListPage(),
    );
  }
}
