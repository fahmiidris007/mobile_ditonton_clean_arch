import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:tvseries/data/datasource/db/database_tv_series_helper.dart';
import 'package:tvseries/data/datasource/tv_series_local_data_source.dart';
import 'package:tvseries/data/datasource/tv_series_remote_data_source.dart';
import 'package:tvseries/domain/repositories/tv_series_repository.dart';

@GenerateMocks([
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvSeriesLocalDataSource,
  DatabaseTvSeriesHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
