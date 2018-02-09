import 'package:flutter/material.dart';
import 'package:test_app/api/models/Movie.dart';
import 'package:test_app/injection/Injector.dart';
import 'package:test_app/presentation/list/MovieListPresenter.dart';

abstract class MovieListPageView {
  void onLoadMoviesComplete(List<Movie> movies);
  void onLoadMoviesError();
}

class MovieListPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    MovieListPageState state = new MovieListPageState(new Injector().movieListPresenter);
    return state;
  }

}

class MovieListPageState extends State<MovieListPage> implements MovieListPageView {

  static const String routeName = "/movies";
  static const double itemHeight = 300.00;

  final IMovieListPresenter _presenter;
  List<Movie> _moviesList;
  bool _isLoading;
  bool _isError = false;

  MovieListPageState(this._presenter) {
    this._presenter.bindView(this);
  }

  ScaffoldState _parentView;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    this._presenter.loadMovies();
  }

  @override
  void onLoadMoviesComplete(List<Movie> movies) {
    setState(() {
      _moviesList = movies;
      _isLoading = false;
    });
  }

  @override
  void onLoadMoviesError() {
    setState(() {
      _isError = true;
      _moviesList = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    _parentView = Scaffold.of(context);

    if (_isLoading) {
      widget = new Center(
          child: new CircularProgressIndicator()
      );
    } else {
      if(_isError || _moviesList == null || _moviesList.isEmpty ) {
        widget = new Center(
            child: new Text("Error fetching server data")
        );
      } else {
        widget = new Expanded(
          child: new Container(
            child: new CustomScrollView(
              scrollDirection: Axis.vertical,
              shrinkWrap: false,
              slivers: <Widget>[
                new SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  sliver: new SliverList(
                    delegate: new SliverChildBuilderDelegate(
                          (context, index) => new MovieRow(_moviesList[index]),
                      childCount: _moviesList.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

    }

    return widget;
  }

}

class MovieRow extends StatelessWidget {

  final Movie _movie;

  MovieRow(this._movie);

  @override
  Widget build(BuildContext context) {
    final movieThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: new Hero(
        tag: "movie-hero-${_movie.movieId}",
        child: new Image(
          image: new NetworkImage(_movie.posterPath),
        ),
      ),
    );

    final baseTextStyle = const TextStyle(
        fontFamily: 'Poppins'
    );
    final regularTextStyle = baseTextStyle.copyWith(
        color: const Color(0xffb6b2df),
        fontSize: 9.0,
        fontWeight: FontWeight.w400
    );
    final subHeaderTextStyle = regularTextStyle.copyWith(
        fontSize: 12.0
    );
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.w600
    );

    Widget _movieValue({String value, String image}) {
      return new Row(
          children: <Widget>[
            new Image.asset(image, height: 12.0),
            new Container(width: 8.0),
            new Text(_movie.voteCount.toString(), style: regularTextStyle),
          ]
      );
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
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0,
              color: new Color(0xff00c6ff)
          ),
        ],
      ),
    );


    final movieCard = new Container(
      child: movieCardContent,
      height: 124.0,
      margin: new EdgeInsets.only(left: 40.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return new GestureDetector(
        onTap: () => Navigator.of(context).push(new PageRouteBuilder(
          //pageBuilder: (_, __, ___) => new DetailPage(planet),
        )),
        child: new Container(
          height: 120.0,
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: new Stack(
            children: <Widget>[
              movieCard,
              movieThumbnail,
            ],
          ),
        )
    );
  }
}

class GradientAppBar extends StatelessWidget {

  final String title;
  final double barHeight = 50.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: new Center(
        child: new Text(title,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 24.0
          ),
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF),
              const Color(0xFF00CCFF)
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp
        ),
      ),
    );
  }
}
