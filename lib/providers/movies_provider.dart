import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;
import 'package:s7_cinema/models/credits_response.dart';
import 'package:s7_cinema/models/models.dart';

import '../helpers/debouncer.dart';
import '../models/search_response.dart';

class MoviesProvider extends ChangeNotifier {

  final String _serviceUrl = 'api.themoviedb.org';
  final String _serviceApiKey = '9b1dcc497efc218750de36540c517e44';
  final String _language = 'es-ES';
  int _popularPage = 1;

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCasting = {};

  // STREAMS IMPLEMENTATION VARIABLES

  final debouncer = Debouncer<String>(
      duration: const Duration(milliseconds: 500)
  );

  final StreamController<List<Movie>> _suggestionsStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionsStream => _suggestionsStreamController.stream;

  //*********************************

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();

    debouncer.value = '';
    debouncer.onValue = (String value) async {
      final movies = await searchMovies(value);
      _suggestionsStreamController.add(movies);
    };
  }

  Future<Response> _getJsonData(String urlEndPath, [int page = 1]) async {
    final url = Uri.https(_serviceUrl, urlEndPath, {
        'api_key': _serviceApiKey,
        'language': _language,
        'page': '$page'
      }
    );

    return await http.get(url);
  }

  Future getOnDisplayMovies() async {
    final Response response = await _getJsonData('/3/movie/now_playing');

    if (response.statusCode == 200) {
      onDisplayMovies = NowPlayingResponse.fromRawJson(response.body).results;
      notifyListeners();
    }
  }

  Future getPopularMovies() async {
    final Response response = await _getJsonData('/3/movie/popular', _popularPage);

    if (response.statusCode == 200) {
      final popularResponse = PopularResponse.fromRawJson(response.body);
      popularMovies = [...popularMovies, ...popularResponse.movies];
      notifyListeners();
      _popularPage++;
    }
  }

  Future<List<Cast>> getMovieCasting(int movieId) async {
    if (moviesCasting.containsKey(movieId)) {
      return moviesCasting[movieId]!;
    }

    final response = await _getJsonData('/3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromRawJson(response.body);

    moviesCasting[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_serviceUrl, '/3/search/movie', {
        'api_key': _serviceApiKey,
        'language': _language,
        'query': query
      }
    );

    final response = await http.get(url);

    final SearchResponse searchResponse = SearchResponse.fromRawJson(response.body);
    return searchResponse.movies;
  }

  void getSuggestionsByQuery(String query) async {
    debouncer.value = query;
  }

}