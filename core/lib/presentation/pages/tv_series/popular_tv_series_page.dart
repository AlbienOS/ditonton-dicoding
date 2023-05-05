import 'package:core/presentation/bloc/tv_series/popular/popular_tv_series_bloc.dart';
import 'package:core/presentation/provider/tv_series/popular_tv_series_notifier.dart';
import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:core/utils/state_enum.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularTvSeriesPage extends StatefulWidget {
  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularTvSeriesBloc>().add(const LoadPopularTvSeriesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
            builder: (context, state) {
          if (state is PopularTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularTvSeriesHasData) {
            return ListView.builder(itemBuilder: (context, index) {
              return TvSeriesCard(state.popularTvList[index]);
            });
          } else if (state is PopularTvSeriesError) {
            FirebaseCrashlytics.instance
                .log('Popular Tv Series Error: ${state.message}');
            return Center(
              key: const Key('error-message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
