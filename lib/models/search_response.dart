import 'dart:convert';
import 'models.dart' show Movie;

class SearchResponse {

  int page;
  List<Movie> movies;
  int totalPages;
  int totalResults;

  SearchResponse({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchResponse.fromRawJson(String str) => SearchResponse.fromJson(json.decode(str));

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
    page: json["page"],
    movies: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

}