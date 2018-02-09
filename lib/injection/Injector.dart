import 'package:test_app/api/models/Movie.dart';
import 'package:test_app/api/services/RemoteMovieService.dart';
import 'package:test_app/presentation/list/MovieListPresenter.dart';

enum BuildType {
  MOCK,
  REMOTE
}

class Injector {

  static final Injector _singleton = new Injector._internal();

  static BuildType _buildType;

  static configureBuildType(BuildType buildType) {
    _buildType = buildType;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  MovieService get movieService {
    switch (_buildType) {
      case BuildType.MOCK:
        return null;
        break;
      default:
        return new RemoteMovieService();
    }
  }

  IMovieListPresenter get movieListPresenter {
    return new MovieListPresenter();
  }

}