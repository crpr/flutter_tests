import 'dart:convert';

import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_app/api/models/Movie.dart';

abstract class MovieService {
  Observable<MoviesResult> discoverMovies();
}

class RemoteMovieService implements MovieService {
  static const _baseUrl = "https://api.themoviedb.org/3/";
  static const _apiKey = "754e9d804b2277630fba2a77bb84f7bd";

  final Client _client;

  RemoteMovieService({Client client}) : this._client = client ?? new Client();

  Observable<MoviesResult> discoverMovies() {
    final path = "discover/movie";

    final response = _client.get(
      "$_baseUrl$path?api_key=$_apiKey",
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    return new Observable<Response>.fromFuture(response)
        .where((response) => response != null)
        .map((response) => JSON.decode(response.body))
        .map((body) => body['results'])
        .map((movies) => new MoviesResult.fromJson(movies));
  }
}

class MoviesResult {
  final List<Movie> movies;

  MoviesResult(this.movies);

  factory MoviesResult.fromJson(List<Map<String, Object>> json) {
    final movies = json.map((Map<String, Object> movie) {
      return new Movie.fromJson(movie);
    }).toList();

    return new MoviesResult(movies);
  }
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
