import 'package:core/presentation/bloc/tv_series/now_playing_tv_series/now_playing_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../utils/state_enum.dart';
import '../../provider/tv_series/now_playing_tv_series_notifier.dart';
import '../../widgets/tv_series_card_list.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  @override
  State<NowPlayingTvSeriesPage> createState() => _NowPlayingTvSeriesState();
}

class _NowPlayingTvSeriesState extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<NowPlayingTvSeriesBloc>()
          .add(const LoadNowPlayingTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
            builder: (context, state) {
          if (state is NowPlayingTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NowPlayingTvSeriesHasData) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  return TvSeriesCard(state.nowPlayingTvList[index]);
                },
                itemCount: state.nowPlayingTvList.length);
          } else if (state is NowPlayingTvSeriesError) {
            FirebaseCrashlytics.instance
                .log('Now Playing Tv Series Error: ${state.message}');
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
