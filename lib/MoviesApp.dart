import 'package:flutter/material.dart';
import 'package:test_app/injection/Injector.dart';
import 'package:test_app/presentation/list/MovieListPage.dart';

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Injector.configureBuildType(BuildType.REMOTE);

    return new MaterialApp(
      title: 'PM Cinema',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        body: new Column(
          children: <Widget>[
            new GradientAppBar("Flutter Movies"),
            new MovieListPage(),
          ],
        ),
      ),
    );
  }
}
