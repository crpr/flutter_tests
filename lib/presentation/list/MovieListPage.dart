import 'package:flutter/material.dart';
import 'package:test_app/api/models/Movie.dart';
import 'package:test_app/injection/Injector.dart';
import 'package:test_app/presentation/list/MovieListPresenter.dart';
import 'package:test_app/presentation/list/MovieRow.dart';

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
      widget = new Center(child: new CircularProgressIndicator());
    } else {
      if (_isError || _moviesList == null || _moviesList.isEmpty) {
        widget = new Center(child: new Text("Error fetching server data"));
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

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 50.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: new Center(
        child: new Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24.0),
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [const Color(0xFF3366FF), const Color(0xFF00CCFF)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
