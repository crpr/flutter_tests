import 'package:test_app/api/models/Movie.dart';
import 'package:test_app/injection/Injector.dart';
import 'package:test_app/presentation/list/MovieListPage.dart';

abstract class IMovieListPresenter {
  void loadMovies();
  void bindView(MovieListPageView view);
}

class MovieListPresenter implements IMovieListPresenter {

  MovieService _service;
  MovieListPageView _view;

  MovieListPresenter() {
    _service = new Injector().movieService;
  }

  @override
  void loadMovies() {
    assert(_view != null);

    _service.fetch()
        .then((items) => _view.onLoadMoviesComplete(items))
        .catchError((onError) {
          _view.onLoadMoviesError();
        });
  }

  @override
  void bindView(MovieListPageView view) {
    this._view = view;
  }

}