import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/bloc/bloc_tv_series/searc_tv_series_bloc.dart';
import 'package:search/domain/usecase/search_tv_series.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../provider/search_tv_series_notifier_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvSeriesBloc searcTvSeriesBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searcTvSeriesBloc = SearchTvSeriesBloc(mockSearchTvSeries);
  });
  test('initial should be empty ', () {
    expect(searcTvSeriesBloc.state, SearchTvSeriesEmpty());
  });

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockSearchTvSeries.execute(tQueryTvSeries))
            .thenAnswer((_) async => Right(tTvSeriesList));
        return searcTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangedTvSeries(tQueryTvSeries)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [SearchTvSeriesLoading(), SearchTvSeriesHasData(tTvSeriesList)],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tQueryTvSeries));
      });

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'should emit [Loading. Error] when data is unsuccessful',
      build: () {
        when(mockSearchTvSeries.execute(tQueryTvSeries))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searcTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangedTvSeries(tQueryTvSeries)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [SearchTvSeriesLoading(), SearchTvSeriesError('Server Failure')],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tQueryTvSeries));
      });
}
