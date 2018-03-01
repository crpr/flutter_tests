import 'package:test_app/api/services/RemoteMovieService.dart';
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

    _service.discoverMovies()
        .map((result) => result.movies)
        .doOnError(() => _view.onLoadMoviesError())
        .listen((movies) => _view.onLoadMoviesComplete(movies));
  }

  @override
  void bindView(MovieListPageView view) {
    this._view = view;
  }

}