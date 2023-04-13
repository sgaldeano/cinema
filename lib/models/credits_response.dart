import 'dart:convert';
import 'models.dart' show Cast;

class CreditsResponse {
  CreditsResponse({
    required this.id,
    required this.cast,
  });

  int id;
  List<Cast> cast;

  factory CreditsResponse.fromRawJson(String str) =>
      CreditsResponse.fromJson(json.decode(str));

  factory CreditsResponse.fromJson(Map<String, dynamic> json) =>
      CreditsResponse(
          id: json["id"],
          cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))
        ),
      );
}