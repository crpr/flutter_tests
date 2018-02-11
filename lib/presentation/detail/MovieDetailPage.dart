import 'package:flutter/material.dart';
import 'package:test_app/api/models/Movie.dart';
import 'package:test_app/presentation/list/MovieListPage.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie _movie;

  MovieDetailPage(this._movie);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Stack(children: <Widget>[
            new Container(
              child: new Center(
                child: new Hero(
                  tag: "movie-hero-${_movie.movieId}",
                  child: new Image(
                    image: new NetworkImage(_movie.posterPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ]),
          new GradientAppBar(_movie.title),
        ],
      ),
    );
  }
}
