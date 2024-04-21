import 'package:equatable/equatable.dart';

class TvSeriesGenre extends Equatable {
  TvSeriesGenre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
