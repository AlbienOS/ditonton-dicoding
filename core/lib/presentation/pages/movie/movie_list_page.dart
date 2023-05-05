import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/movie/now_playing/now_playing_bloc.dart';
import 'package:core/presentation/bloc/movie/popular/popular_bloc.dart';
import 'package:core/presentation/bloc/movie/top_rated/top_rated_bloc.dart';
import 'package:core/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/movie.dart';
import '../../../styles/text_style.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingBloc>().add(const LoadNowPlayingEvent());
      context.read<PopularBloc>().add(const LoadPopularMovie());
      context.read<TopRatedBloc>().add(const LoadTopRatedMovie());
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
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingBloc, NowPlayingState>(
                builder: (context, state) {
              if (state is NowPlayingMovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingMovieHasData) {
                return MovieList(state.movieList);
              } else if (state is NowPlayingMovieError) {
                FirebaseCrashlytics.instance
                    .log('Now Playing Movie List Error: ${state.errorMessage}');
                return Center(
                  child: Text(state.errorMessage),
                );
              } else {
                return Container();
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, POPULAR_MOVIE_ROUTE_NAME),
            ),
            BlocBuilder<PopularBloc, PopularState>(builder: (context, state) {
              if (state is PopularMovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularMovieHasData) {
                return MovieList(state.popularList);
              } else if (state is PopularMovieError) {
                FirebaseCrashlytics.instance
                    .log('Popular Movie List Error : ${state.message}');
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TOP_RATED_MOVIE_ROUTE_NAME),
            ),
            BlocBuilder<TopRatedBloc, TopRatedState>(builder: (context, state) {
              if (state is TopRatedLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedHasData) {
                return MovieList(state.topRatedList);
              } else if (state is TopRatedError) {
                FirebaseCrashlytics.instance
                    .log('Top Rated Movie List Error: ${state.message}');
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MOVIE_DETAIL_ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
