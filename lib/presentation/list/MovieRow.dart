import 'package:flutter/material.dart';
import 'package:test_app/api/models/Movie.dart';
import 'package:test_app/presentation/detail/MovieDetailPage.dart';

class MovieRow extends StatelessWidget {
  final Movie _movie;

  MovieRow(this._movie);

  @override
  Widget build(BuildContext context) {
    final movieThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new Hero(
        tag: "movie-hero-${_movie.movieId}",
        child: new Image(
          image: new NetworkImage(_movie.posterPath),
        ),
      ),
    );

    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(color: Colors.black54, fontSize: 9.0, fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
    final headerTextStyle = baseTextStyle.copyWith(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600);

    Widget _movieValue({String value, String image}) {
      return new Row(children: <Widget>[
        new Image.asset(image, height: 12.0),
        new Container(width: 8.0),
        new Text(_movie.voteCount.toString(), style: regularTextStyle),
      ]);
    }

    final movieCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(30.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(_movie.title, style: headerTextStyle),
          new Container(height: 10.0),
          new Text(_movie.releaseDate, style: subHeaderTextStyle),
          new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0), height: 2.0, width: 18.0, color: new Color(0xff00c6ff)),
        ],
      ),
    );

    final movieCard = new Container(
      child: movieCardContent,
      height: 124.0,
      margin: new EdgeInsets.only(left: 40.0),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new NetworkImage(_movie.backdropPath),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
        ),
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: new Offset(0.0, 5.0),
          ),
        ],
      ),
    );

    return new Container(
      height: 120.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: new FlatButton(
        onPressed: () => _navigateTo(context),
        child: new Stack(
          children: <Widget>[
            movieCard,
            movieThumbnail,
          ],
        ),
      ),
    );
  }

  _navigateTo(context) {
    Navigator.push(context, new MaterialPageRoute(builder: (_) => new MovieDetailPage(_movie)));
  }
}
