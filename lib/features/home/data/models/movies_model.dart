class MoviesModel {
  final List<Result> results;

  MoviesModel({
    required this.results,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  final int id;
  final String originalTitle;
  final String posterPath;
  final String backdropPath;

  Result({
    required this.id,
    required this.originalTitle,
    required this.posterPath,
    required this.backdropPath,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        backdropPath: json["backdrop_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "original_title": originalTitle,
        "poster_path": posterPath,
        "backdrop_path": backdropPath,
      };
}
