import 'dart:convert';

class Movie {

  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  String? heroId;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.heroId
  });

  get fullPosterPath {
    return posterPath != null
        ? 'https://image.tmdb.org/t/p/w500$posterPath'
        : 'https://via.placeholder.com/300x400';
  }

  get fullBackdropPath {
    return backdropPath != null
        ? 'https://image.tmdb.org/t/p/w500$backdropPath'
        : 'https://via.placeholder.com/300x400';
  }

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    adult           : json["adult"],
    backdropPath    : json["backdrop_path"],
    genreIds        : List<int>.from(json["genre_ids"].map((x) => x)),
    id              : json["id"],
    originalLanguage: json["original_language"],
    originalTitle   : json["original_title"],
    overview        : json["overview"],
    popularity      : json["popularity"]?.toDouble(),
    posterPath      : json["poster_path"],
    releaseDate     : json["release_date"],
    title           : json["title"],
    video           : json["video"],
    voteAverage     : json["vote_average"]?.toDouble(),
    voteCount       : json["vote_count"],
  );

}