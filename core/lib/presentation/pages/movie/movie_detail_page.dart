import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:core/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../styles/colors.dart';
import '../../../styles/text_style.dart';
import '../../../utils/state_enum.dart';
import '../../provider/movie/movie_detail_notifier.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id, Key? key}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(callMovieDetailById(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailHasData) {
            final movie = state.movieDetail;
            return SafeArea(
              child: DetailContent(movie),
            );
          } else if (state is MovieDetailError) {
            FirebaseCrashlytics.instance
                .log('Movie Detail Error: ${state.failureMessage}');
            return Text(state.failureMessage);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final MovieDetail movie;

  DetailContent(this.movie, {Key? key}) : super(key: key);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  void initState() {
    super.initState();
    context
        .read<MovieWatchlistBloc>()
        .add(LoadWatchlistStatus(widget.movie.id));
    context
        .read<MovieRecommendationBloc>()
        .add(callMovieRecommendationById(widget.movie.id));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
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
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
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
                              widget.movie.title,
                              style: kHeading5,
                            ),
                            BlocBuilder<MovieWatchlistBloc,
                                MovieWatchlistState>(builder: (context, state) {
                              final isAddedWatchlist =
                                  (state is MovieWatchlistInitial)
                                      ? false
                                      : (state as MovieWatchlistStatus)
                                          .watchlistStatus;
                              return ElevatedButton(
                                onPressed: () async {
                                  if (!isAddedWatchlist) {
                                    context
                                        .read<MovieWatchlistBloc>()
                                        .add(InsertWatchlist(widget.movie));
                                  } else {
                                    context
                                        .read<MovieWatchlistBloc>()
                                        .add(DoRemoveWatchlist(widget.movie));
                                  }
                                  if (state is MovieRemoveWatchlistSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration:
                                                Duration(milliseconds: 200),
                                            content: Text(
                                                'Remove Watchlist is Success')));
                                  } else if (state
                                      is MovieRemoveWatchlistError) {
                                    FirebaseCrashlytics.instance.log(
                                        'Movie Detail Remove Watchlist Error: ${state.message}');
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(state.message),
                                          );
                                        });
                                  }
                                  if (state is MovieInsertWatchlistSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration:
                                                Duration(milliseconds: 200),
                                            content: Text(
                                                'Insert Watchlist is Success')));
                                  } else if (state
                                      is MovieInsertWatchlistError) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          FirebaseCrashlytics.instance.log(
                                              'Movie Detail Insert Watchlist Error: ${state.message}');
                                          return AlertDialog(
                                            content: Text(state.message),
                                          );
                                        });
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isAddedWatchlist
                                        ? Icon(Icons.check)
                                        : Icon(Icons.add),
                                    Text('Watchlist'),
                                  ],
                                ),
                              );
                            }),
                            Text(
                              _showGenres(widget.movie.genres),
                            ),
                            Text(
                              _showDuration(widget.movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieRecommendationBloc,
                                MovieRecommendationState>(
                              builder: (context, state) {
                                if (state is MovieRecommendationEmpty) {
                                  return Center(
                                    child: Text('Empty'),
                                  );
                                } else if (state
                                    is MovieRecommendationLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is MovieRecommendationHasData) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie =
                                            state.recommendationList[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MOVIE_DETAIL_ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          state.recommendationList.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
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
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
