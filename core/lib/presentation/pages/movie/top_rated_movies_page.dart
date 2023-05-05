import 'package:core/presentation/bloc/movie/top_rated/top_rated_bloc.dart';
import 'package:core/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/utils/state_enum.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopRatedMoviesPage extends StatefulWidget {
  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedBloc>().add(const LoadTopRatedMovie());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedBloc, TopRatedState>(
          builder: (context, state) {
            if (state is TopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MovieCard(state.topRatedList[index]);
                },
                itemCount: state.topRatedList.length,
              );
            } else if (state is TopRatedError) {
              FirebaseCrashlytics.instance
                  .log('Top Rated Movie Error: ${state.message}');
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
