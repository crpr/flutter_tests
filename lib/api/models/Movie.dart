import 'dart:async';

class Movie {

  static final String baseImagePath = "https://image.tmdb.org/t/p/w500";

  final int movieId;
  final bool adult;
  final String backdropPath;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final String posterPath;
  final double popularity;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  const Movie({this.movieId, this.adult, this.backdropPath, this.originalLanguage,
              this.originalTitle, this.overview, this.releaseDate, this.posterPath,
              this.popularity, this.title, this.video, this.voteAverage, this.voteCount});

  Movie.fromMap(Map<String, dynamic>  map) :
        movieId = map['id'],
        adult = map['adult'],
        backdropPath = baseImagePath+"${map['backdrop_path']}",
        originalLanguage = "${map['original_language']}",
        originalTitle = "${map['original_title']}",
        overview = "${map['overview']}",
        releaseDate = "${map['release_date']}",
        posterPath = baseImagePath+"${map['poster_path']}",
        popularity = map['popularity'],
        title = "${map['title']}",
        video = map['video'],
        voteAverage = double.parse("${map['vote_average']}"),
        voteCount = map['vote_count'];

}

abstract class MovieService {
  Future<List<Movie>> fetch();
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}