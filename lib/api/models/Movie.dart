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

  const Movie(
      {this.movieId,
      this.adult,
      this.backdropPath,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.releaseDate,
      this.posterPath,
      this.popularity,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  Movie.fromJson(Map<String, Object> json)
      : movieId = json['id'],
        adult = json['adult'],
        backdropPath = "$baseImagePath${json['backdrop_path']}",
        originalLanguage = "${json['original_language']}",
        originalTitle = "${json['original_title']}",
        overview = "${json['overview']}",
        releaseDate = "${json['release_date']}",
        posterPath = "$baseImagePath${json['poster_path']}",
        popularity = json['popularity'],
        title = "${json['title']}",
        video = json['video'],
        voteAverage = double.parse("${json['vote_average']}"),
        voteCount = json['vote_count'];
}
