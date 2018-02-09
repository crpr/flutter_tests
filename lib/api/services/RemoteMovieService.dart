import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:test_app/api/models/Movie.dart';

class RemoteMovieService implements MovieService {

  static const _apiKey = "754e9d804b2277630fba2a77bb84f7bd";
  static const _apiUrl = "https://api.themoviedb.org/3/discover/movie?api_key=" + _apiKey;

  final JsonDecoder _decoder = new JsonDecoder();

  @override
  Future<List<Movie>> fetch() async {
    var httpClient = createHttpClient();
    var response = await httpClient.get(_apiUrl);

    final String jsonBody = response.body;
    final statusCode = response.statusCode;

    if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException("Error while getting movies [StatusCode:$statusCode, Error:$response]");
    }

    final moviesContainer = _decoder.convert(jsonBody);
    final List movieItems = moviesContainer['results'];

    return movieItems.map((movieRaw) => new Movie.fromMap(movieRaw))
        .toList();
  }

}