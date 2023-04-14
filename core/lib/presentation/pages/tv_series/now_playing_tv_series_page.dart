import 'package:flutter/material.dart';
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
    Future.microtask(() =>
        Provider.of<NowPlayingTvSeriesNotifier>(context, listen: false)
            .fetchNowPlayingTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Tv Series'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Consumer<NowPlayingTvSeriesNotifier>(
            builder: (context, data, child) {
          if (data.nowPlayingState == RequestState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (data.nowPlayingState == RequestState.Loaded) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.nowPlayingTvSeriesList[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: data.nowPlayingTvSeriesList.length);
          } else {
            return Center(
              key: Key('error-message'),
              child: Text(data.message),
            );
          }
        }),
      ),
    );
  }
}
