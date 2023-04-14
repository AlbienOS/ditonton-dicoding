import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/bloc/bloc_movie/search_bloc.dart';

import '../../bloc/bloc_tv_series/searc_tv_series_bloc.dart';

class SearchPage extends StatelessWidget {
  final SearchContext searchContext;

  SearchPage(this.searchContext);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: ((query) {
                switch (searchContext) {
                  case SearchContext.movie:
                    context.read<SearchBloc>().add(OnQueryChanged(query));
                    return;
                  case SearchContext.tvSeries:
                    context
                        .read<SearchTvSeriesBloc>()
                        .add(OnQueryChangedTvSeries(query));
                    break;
                  default:
                }
              }),
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            searchContext == SearchContext.movie
                ? _MovieSearchResultWidget()
                : _TvSeriesSearchResultWidget(),
          ],
        ),
      ),
    );
  }
}

class _MovieSearchResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHasData) {
          final result = state.result;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = result[index];
                return MovieCard(movie);
              },
              itemCount: result.length,
            ),
          );
        } else if (state is SearchError) {
          return Expanded(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else {
          return Expanded(child: Container());
        }
      },
    );
  }
}

class _TvSeriesSearchResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
      builder: (context, state) {
        if (state is SearchTvSeriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchTvSeriesHasData) {
          final result = state.result;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tvSeries = result[index];
                return TvSeriesCard(tvSeries);
              },
              itemCount: result.length,
            ),
          );
        } else if (state is SearchTvSeriesError) {
          return Expanded(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else {
          return Expanded(child: Container());
        }
      },
    );
  }
}
