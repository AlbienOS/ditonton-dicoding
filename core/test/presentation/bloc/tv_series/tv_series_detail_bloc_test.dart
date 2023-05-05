import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:core/presentation/bloc/tv_series/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvSeriesDetailBloc = TvSeriesDetailBloc(mockGetTvSeriesDetail);
  });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should return state initialState',
      build: () => tvSeriesDetailBloc,
      verify: (bloc) {
        expect(tvSeriesDetailBloc.state, TvSeriesDetailInitial());
      });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should return emits [Loading, HasData] when usecase is success.',
      build: () {
        when(mockGetTvSeriesDetail.execute(2))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(CallTvSeriesDetailById(2)),
      expect: () => [
            const TvSeriesDetailLoading(),
            TvSeriesDetailHasData(testTvSeriesDetail)
          ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(2));
      });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'should return emits [Loading, Error] when usecase is failed.',
    build: () {
      when(mockGetTvSeriesDetail.execute(2))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(CallTvSeriesDetailById(2)),
    expect: () =>
        [const TvSeriesDetailLoading(), TvSeriesDetailError('Server Failure')],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(2));
    },
  );
}
