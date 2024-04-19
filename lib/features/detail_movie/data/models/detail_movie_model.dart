class DetailMovieModel {
  final List<Genre> genres;
  final String overview;
  final String posterPath;
  final String title;
  final double voteAverage;

  DetailMovieModel({
    required this.genres,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
  });

  factory DetailMovieModel.fromJson(Map<String, dynamic> json) =>
      DetailMovieModel(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        overview: json["overview"],
        posterPath: json["poster_path"],
        title: json["title"],
        voteAverage: json["vote_average"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "overview": overview,
        "poster_path": posterPath,
        "title": title,
        "vote_average": voteAverage,
      };
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
