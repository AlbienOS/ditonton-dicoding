import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/presentation/bloc/tv_series/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:core/presentation/bloc/tv_series/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:core/presentation/bloc/tv_series/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:core/presentation/pages/tv_series/tv_series_list_page.dart';
import 'package:core/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:core/presentation/widgets/season_card.dart';
import 'package:core/styles/colors.dart';
import 'package:core/utils/state_enum.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/genre.dart';
import '../../../styles/text_style.dart';

class TvSeriesDetailPage extends StatefulWidget {
  final int tvId;
  TvSeriesDetailPage({required this.tvId});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<TvSeriesDetailBloc>()
          .add(CallTvSeriesDetailById(widget.tvId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
        builder: (context, state) {
          if (state is TvSeriesDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesDetailHasData) {
            final tvSeriesDetail = state.tvSeriesDetail;
            return SafeArea(
              child: DetailContentTvSeries(tvSeriesDetail: tvSeriesDetail),
            );
          } else if (state is TvSeriesDetailError) {
            FirebaseCrashlytics.instance
                .log('Tv Series Detail Error: ${state.message}');
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContentTvSeries extends StatefulWidget {
  final TvSeriesDetail tvSeriesDetail;

  DetailContentTvSeries({required this.tvSeriesDetail, Key? key})
      : super(key: key);

  @override
  State<DetailContentTvSeries> createState() => _DetailContentTvSeriesState();
}

class _DetailContentTvSeriesState extends State<DetailContentTvSeries> {
  @override
  void initState() {
    Future.microtask(() {
      context
          .read<TvSeriesWatchlistBloc>()
          .add(CallWatchlistStatusById(widget.tvSeriesDetail.id));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.tvSeriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tvSeriesDetail.name,
                              style: kHeading5,
                            ),
                            BlocBuilder<TvSeriesWatchlistBloc,
                                    TvSeriesWatchlistState>(
                                builder: (context, state) {
                              final isAddedWatchlist =
                                  (state is TvSeriesWatchlistInitial)
                                      ? false
                                      : (state as TvSeriesWatchlistGetStatus)
                                          .watchlistTvSeriesStatus
                                          .getOrElse(() => false);
                              return ElevatedButton(
                                onPressed: (() async {
                                  if (isAddedWatchlist == true) {
                                    context.read<TvSeriesWatchlistBloc>().add(
                                        InsertWatchlistTvSeries(
                                            widget.tvSeriesDetail));

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Added to Watchlist')));
                                  } else {
                                    context.read<TvSeriesWatchlistBloc>().add(
                                        DoRemoveWatchlistTvSeries(
                                            widget.tvSeriesDetail));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Remove from Watchlist')));
                                  }
                                  if (state is TvSeriesRemoveWatchlistSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration:
                                                Duration(milliseconds: 200),
                                            content: Text(
                                                'Remove Watchlist is Success')));
                                  } else if (state
                                      is TvSeriesRemoveWatchlistError) {
                                    FirebaseCrashlytics.instance.log(
                                        'Remove Watchlist Error : ${state.message}');
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(state.message),
                                          );
                                        });
                                  }

                                  if (state is TvSeriesInsertWatchlistSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration:
                                                Duration(milliseconds: 200),
                                            content: Text(
                                                'Insert Watchlist is Success')));
                                  } else if (state
                                      is TvSeriesInsertWatchlistError) {
                                    FirebaseCrashlytics.instance.log(
                                        'Insert Watchlist Error : ${state.message}');
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(state.message),
                                          );
                                        });
                                  }
                                }),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isAddedWatchlist
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.add),
                                    const Text('Watchlist'),
                                  ],
                                ),
                              );
                            }),
                            Text(
                              _showGenres(widget.tvSeriesDetail.genres),
                            ),
                            Text(_showEpisodesOfSeasons(
                                widget.tvSeriesDetail.numberOfSeasons,
                                widget.tvSeriesDetail.numberOfEpisodes)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvSeriesDetail.voteAverage / 2,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvSeriesDetail.voteAverage}'),
                                Text(
                                    '${widget.tvSeriesDetail.voteCount} votes'),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(widget.tvSeriesDetail.overview),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      widget.tvSeriesDetail.seasons!.length,
                                  itemBuilder: (context, index) {
                                    final season =
                                        widget.tvSeriesDetail.seasons![index];
                                    return SeasonCard(season);
                                  }),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text('Recommendations', style: kHeading6),
                            BlocBuilder<TvSeriesRecommendationBloc,
                                    TvSeriesRecommendationState>(
                                builder: (context, state) {
                              if (state is TvSeriesRecommendationLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state
                                  is TvSeriesRecommendationHasData) {
                                return TvSeriesList(state.tvRecommendationList);
                              } else if (state is TvSeriesRecommendationError) {
                                FirebaseCrashlytics.instance.log(
                                    'TvSeries List Error: ${state.message}');
                                return SizedBox(
                                  height: 32,
                                  child: Center(
                                    child: Text(state.message),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    )
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back)),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ',';
    }
    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showEpisodesOfSeasons(int numberOfSeasons, int numberOfEpisodes) {
    String result = '';
    result += '$numberOfSeasons';
    if (numberOfSeasons > 1) {
      result += 'seasons,';
    } else {
      result += 'season, ';
    }
    result += '$numberOfEpisodes';
    if (numberOfEpisodes > 1) {
      result += ' Episodes ';
    } else {
      result += ' Episode, ';
    }

    return (result += 'total');
  }
}
