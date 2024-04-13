import 'package:ditonton/domain/entities/tvseries/tv_series_genre.dart';
import 'package:equatable/equatable.dart';

class TvSeriesGenreModel extends Equatable {
  final int id;
  final String name;

  TvSeriesGenreModel({
    required this.id,
    required this.name,
  });

  factory TvSeriesGenreModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesGenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  TvSeriesGenre toEntity() => TvSeriesGenre(id: id, name: name);

  @override
  List<Object?> get props => [id, name];
}
