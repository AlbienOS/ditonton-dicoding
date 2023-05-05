import 'package:core/common/utils.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/tv_series/watchlist_tv_series.dart/watchlist_tv_series_bloc.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/colors.dart';

class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with RouteAware, SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMovieBloc>().add(const LoadWatchlistMovie());
      context.read<WatchlistTvSeriesBloc>().add(const LoadWatchlistTvSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(const LoadWatchlistMovie());
    context.read<WatchlistTvSeriesBloc>().add(const LoadWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        bottom: TabBar(
            indicatorColor: kMikadoYellow,
            controller: _tabController,
            tabs: const [Tab(text: 'Movies'), Tab(text: 'Tv Series')]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_MovieWatchlistWidget(), _TvSeriesWatchlistWidget()],
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class _MovieWatchlistWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
        builder: (context, state) {
          if (state is WatchlistMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return MovieCard(state.watchlistMovie[index]);
              },
              itemCount: state.watchlistMovie.length,
            );
          } else if (state is WatchlistMovieError) {
            FirebaseCrashlytics.instance
                .log('Watchlist Movie Error: ${state.message}');
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _TvSeriesWatchlistWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        builder: (context, state) {
          if (state is WatchlistTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvSeriesHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = state.watchlistTvSeries[index];
                return TvSeriesCard(tvSeries);
              },
              itemCount: state.watchlistTvSeries.length,
            );
          } else if (state is WatchlistTvSeriesError) {
            FirebaseCrashlytics.instance
                .log('Watchlist Tv Series Error: ${state.message}');
            return Center(
              key: Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
