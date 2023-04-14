import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/presentation/pages/tv_series/tv_series_list_page.dart';
import 'package:core/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:core/presentation/widgets/season_card.dart';
import 'package:core/styles/colors.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
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
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
        ..fetchTvSeriesDetail(widget.tvId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeriesDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeriesDetailState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeriesDetailState == RequestState.Loaded) {
            final tvSeriesDetail = provider.tvSeriesDetail;
            final isAddedWatchlist = provider.addedToWatchlist;
            return SafeArea(
                child: DetailContentTvSeries(
                    tvSeriesDetail: tvSeriesDetail!,
                    isAddedWatchlist: isAddedWatchlist));
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContentTvSeries extends StatelessWidget {
  final TvSeriesDetail tvSeriesDetail;
  final bool isAddedWatchlist;

  DetailContentTvSeries(
      {required this.tvSeriesDetail, required this.isAddedWatchlist});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
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
                              tvSeriesDetail.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: (() async {
                                if (!isAddedWatchlist) {
                                  await Provider.of<TvSeriesDetailNotifier>(
                                          context,
                                          listen: false)
                                      .insertToWatchlist(tvSeriesDetail);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Added to Watchlist')));
                                } else {
                                  await Provider.of<TvSeriesDetailNotifier>(
                                          context,
                                          listen: false)
                                      .removeFromWatchlist(tvSeriesDetail);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Remove from Watchlist')));
                                }
                              }),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvSeriesDetail.genres),
                            ),
                            Text(_showEpisodesOfSeasons(
                                tvSeriesDetail.numberOfSeasons,
                                tvSeriesDetail.numberOfEpisodes)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeriesDetail.voteAverage / 2,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeriesDetail.voteAverage}'),
                                Text('${tvSeriesDetail.voteCount} votes'),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(tvSeriesDetail.overview),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: tvSeriesDetail.seasons!.length,
                                  itemBuilder: (context, index) {
                                    final season =
                                        tvSeriesDetail.seasons![index];
                                    return SeasonCard(season);
                                  }),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text('Recommendations', style: kHeading6),
                            Consumer<TvSeriesDetailNotifier>(
                                builder: (context, data, child) {
                              if (data.recommendationState ==
                                  RequestState.Loading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (data.recommendationState ==
                                  RequestState.Loaded) {
                                final recommendationList =
                                    data.tvSeriesRecommendations;
                                return TvSeriesList(recommendationList);
                              } else if (data.recommendationState ==
                                  RequestState.Empty) {
                                return SizedBox(
                                  height: 32,
                                  child: Center(
                                    child: Text('No recommendations available'),
                                  ),
                                );
                              } else {
                                return Text('Unknown Error');
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
