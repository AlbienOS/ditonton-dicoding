import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/tv_series/now_playing_tv_series/now_playing_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series/popular/popular_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series/top_rated/top_rated_tv_series_bloc.dart';
import 'package:core/routes.dart';
import 'package:core/styles/text_style.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv_series.dart';
import '../../../utils/constants.dart';

class TvSeriesListPage extends StatefulWidget {
  @override
  State<TvSeriesListPage> createState() => _TvSeriesListPageState();
}

class _TvSeriesListPageState extends State<TvSeriesListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<NowPlayingTvSeriesBloc>()
          .add(const LoadNowPlayingTvSeries());
      context.read<PopularTvSeriesBloc>().add(const LoadPopularTvSeriesEvent());
      context.read<TopRatedTvSeriesBloc>().add(const LoadTopRatedTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
                title: 'Now Playing',
                onTap: () {
                  Navigator.pushNamed(
                      context, NOW_PLAYING_TV_SERIES_ROUTE_NAME);
                }),
            BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
                builder: (context, state) {
              if (state is NowPlayingTvSeriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingTvSeriesHasData) {
                return TvSeriesList(state.nowPlayingTvList);
              } else if (state is NowPlayingTvSeriesError) {
                FirebaseCrashlytics.instance
                    .log('Now Playing Tv Series Error: ${state.message}');
                return Text(state.message);
              } else {
                return const Text('else');
              }
            }),
            _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, POPULAR_TV_SERIES_ROUTE_NAME);
                }),
            BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
                builder: (context, state) {
              if (state is PopularTvSeriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularTvSeriesHasData) {
                return TvSeriesList(state.popularTvList);
              } else if (state is PopularTvSeriesError) {
                FirebaseCrashlytics.instance
                    .log('Popular Tv Series Error: ${state.message}');
                return Text(state.message);
              } else {
                return const Text('Else');
              }
            }),
            _buildSubHeading(title: 'Top Rated', onTap: null),
            BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
                builder: (context, state) {
              if (state is TopRatedTvSeriesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TopRatedTvSeriesHasData) {
                return TvSeriesList(state.topRatedTvList);
              } else if (state is TopRatedTvSeriesError) {
                FirebaseCrashlytics.instance
                    .log('Top Rated TvSeries Error : ${state.message}');
                return Text(state.message);
              } else {
                return const Text('else');
              }
            })
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function()? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;

  TvSeriesList(this.tvSeriesList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, TV_SERIES_DETAIL_ROUTE_NAME,
                    arguments: tvSeries.id);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
