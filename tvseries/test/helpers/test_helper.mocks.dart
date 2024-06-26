// Mocks generated by Mockito 5.4.4 from annotations
// in tvseries/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:convert' as _i17;
import 'dart:typed_data' as _i18;

import 'package:core/utils/failure.dart' as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i14;
import 'package:sqflite/sqflite.dart' as _i16;
import 'package:tvseries/data/datasource/db/database_tv_series_helper.dart'
    as _i15;
import 'package:tvseries/data/datasource/tv_series_local_data_source.dart'
    as _i12;
import 'package:tvseries/data/datasource/tv_series_remote_data_source.dart'
    as _i10;
import 'package:tvseries/data/models/tv_series_detail_model.dart' as _i3;
import 'package:tvseries/data/models/tv_series_model.dart' as _i11;
import 'package:tvseries/data/models/tv_series_table.dart' as _i13;
import 'package:tvseries/domain/entities/tv_series.dart' as _i8;
import 'package:tvseries/domain/entities/tv_series_detail.dart' as _i9;
import 'package:tvseries/domain/repositories/tv_series_repository.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvSeriesDetailResponse_1 extends _i1.SmartFake
    implements _i3.TvSeriesDetailResponse {
  _FakeTvSeriesDetailResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_2 extends _i1.SmartFake implements _i4.Response {
  _FakeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_3 extends _i1.SmartFake
    implements _i4.StreamedResponse {
  _FakeStreamedResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvSeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRepository extends _i1.Mock
    implements _i5.TvSeriesRepository {
  MockTvSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>
      getNowPlayingTvSeries() => (super.noSuchMethod(
            Invocation.method(
              #getNowPlayingTvSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i8.TvSeries>>(
              this,
              Invocation.method(
                #getNowPlayingTvSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>
      getPopularTvSeries() => (super.noSuchMethod(
            Invocation.method(
              #getPopularTvSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i8.TvSeries>>(
              this,
              Invocation.method(
                #getPopularTvSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>
      getTopRatedTvSeries() => (super.noSuchMethod(
            Invocation.method(
              #getTopRatedTvSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i8.TvSeries>>(
              this,
              Invocation.method(
                #getTopRatedTvSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, _i9.TvSeriesDetail>> getTvSeriesDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesDetail,
          [id],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i9.TvSeriesDetail>>.value(
                _FakeEither_0<_i7.Failure, _i9.TvSeriesDetail>(
          this,
          Invocation.method(
            #getTvSeriesDetail,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i9.TvSeriesDetail>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>
      getTvSeriesRecommendations(int? id) => (super.noSuchMethod(
            Invocation.method(
              #getTvSeriesRecommendations,
              [id],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i8.TvSeries>>(
              this,
              Invocation.method(
                #getTvSeriesRecommendations,
                [id],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>> searchTvSeries(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTvSeries,
          [query],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>.value(
                _FakeEither_0<_i7.Failure, List<_i8.TvSeries>>(
          this,
          Invocation.method(
            #searchTvSeries,
            [query],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveWatchlist(
          _i9.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [tvSeries],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [tvSeries],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeWatchlist(
          _i9.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tvSeries],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [tvSeries],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);

  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlist,
          [id],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>
      getWatchlistTvSeries() => (super.noSuchMethod(
            Invocation.method(
              #getWatchlistTvSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i8.TvSeries>>(
              this,
              Invocation.method(
                #getWatchlistTvSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvSeries>>>);
}

/// A class which mocks [TvSeriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRemoteDataSource extends _i1.Mock
    implements _i10.TvSeriesRemoteDataSource {
  MockTvSeriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i11.TvSeriesModel>> getNowPlayingTvSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingTvSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i11.TvSeriesModel>>.value(<_i11.TvSeriesModel>[]),
      ) as _i6.Future<List<_i11.TvSeriesModel>>);

  @override
  _i6.Future<List<_i11.TvSeriesModel>> getPopularTvSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularTvSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i11.TvSeriesModel>>.value(<_i11.TvSeriesModel>[]),
      ) as _i6.Future<List<_i11.TvSeriesModel>>);

  @override
  _i6.Future<List<_i11.TvSeriesModel>> getTopRatedTvSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedTvSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i11.TvSeriesModel>>.value(<_i11.TvSeriesModel>[]),
      ) as _i6.Future<List<_i11.TvSeriesModel>>);

  @override
  _i6.Future<_i3.TvSeriesDetailResponse> getTvSeriesDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesDetail,
          [id],
        ),
        returnValue: _i6.Future<_i3.TvSeriesDetailResponse>.value(
            _FakeTvSeriesDetailResponse_1(
          this,
          Invocation.method(
            #getTvSeriesDetail,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.TvSeriesDetailResponse>);

  @override
  _i6.Future<List<_i11.TvSeriesModel>> getTvSeriesRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesRecommendations,
          [id],
        ),
        returnValue:
            _i6.Future<List<_i11.TvSeriesModel>>.value(<_i11.TvSeriesModel>[]),
      ) as _i6.Future<List<_i11.TvSeriesModel>>);

  @override
  _i6.Future<List<_i11.TvSeriesModel>> searchTvSeries(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTvSeries,
          [query],
        ),
        returnValue:
            _i6.Future<List<_i11.TvSeriesModel>>.value(<_i11.TvSeriesModel>[]),
      ) as _i6.Future<List<_i11.TvSeriesModel>>);
}

/// A class which mocks [TvSeriesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesLocalDataSource extends _i1.Mock
    implements _i12.TvSeriesLocalDataSource {
  MockTvSeriesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertWatchlist(_i13.TvSeriesTable? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [tvSeries],
        ),
        returnValue: _i6.Future<String>.value(_i14.dummyValue<String>(
          this,
          Invocation.method(
            #insertWatchlist,
            [tvSeries],
          ),
        )),
      ) as _i6.Future<String>);

  @override
  _i6.Future<String> removeWatchlist(_i13.TvSeriesTable? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tvSeries],
        ),
        returnValue: _i6.Future<String>.value(_i14.dummyValue<String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [tvSeries],
          ),
        )),
      ) as _i6.Future<String>);

  @override
  _i6.Future<_i13.TvSeriesTable?> getTvSeriesById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesById,
          [id],
        ),
        returnValue: _i6.Future<_i13.TvSeriesTable?>.value(),
      ) as _i6.Future<_i13.TvSeriesTable?>);

  @override
  _i6.Future<List<_i13.TvSeriesTable>> getWatchlistTvSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTvSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i13.TvSeriesTable>>.value(<_i13.TvSeriesTable>[]),
      ) as _i6.Future<List<_i13.TvSeriesTable>>);
}

/// A class which mocks [DatabaseTvSeriesHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseTvSeriesHelper extends _i1.Mock
    implements _i15.DatabaseTvSeriesHelper {
  MockDatabaseTvSeriesHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i16.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i6.Future<_i16.Database?>.value(),
      ) as _i6.Future<_i16.Database?>);

  @override
  _i6.Future<int> insertWatchlist(_i13.TvSeriesTable? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [tvSeries],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);

  @override
  _i6.Future<int> removeWatchlist(_i13.TvSeriesTable? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tvSeries],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);

  @override
  _i6.Future<Map<String, dynamic>?> getTvSeriesById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesById,
          [id],
        ),
        returnValue: _i6.Future<Map<String, dynamic>?>.value(),
      ) as _i6.Future<Map<String, dynamic>?>);

  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistTvSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTvSeries,
          [],
        ),
        returnValue: _i6.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i6.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<String>.value(_i14.dummyValue<String>(
          this,
          Invocation.method(
            #read,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<String>);

  @override
  _i6.Future<_i18.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i18.Uint8List>.value(_i18.Uint8List(0)),
      ) as _i6.Future<_i18.Uint8List>);

  @override
  _i6.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i6.Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_3(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i6.Future<_i4.StreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
