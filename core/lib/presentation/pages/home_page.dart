import 'package:core/presentation/pages/tv_series/tv_series_list_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/routes.dart';
import 'package:core/routes.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'movie/movie_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // these are just numbers, nothing special
  static const moviePageIndex = 0x090;
  static const tvSeriesPageIndex = 0xbee;

  final _pages = {
    moviePageIndex: MovieListPage(),
    tvSeriesPageIndex: TvSeriesListPage(),
  };

  int _currentIndex = -1;

  @override
  void initState() {
    super.initState();
    _currentIndex = moviePageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movie list'),
              onTap: () {
                Navigator.pop(context);
                if (_currentIndex == moviePageIndex) {
                  // you're pressing the same thing,
                  // do nothing besides closing the drawer.
                } else {
                  // you're moving to somewhere else,
                  // do setState to refresh this entire page.
                  setState(() {
                    _currentIndex = moviePageIndex;
                  });
                }
              },
            ),
            ListTile(
                leading: Icon(Icons.tv),
                title: Text('TV Series list'),
                onTap: () {
                  Navigator.pop(context);
                  if (_currentIndex == tvSeriesPageIndex) {
                    // you're pressing the same thing,
                    // do nothing besides closing the drawer.
                  } else {
                    // you're moving to somewhere else,
                    // do setState to refresh this entire page.
                    setState(() {
                      _currentIndex = tvSeriesPageIndex;
                    });
                  }
                }),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlists'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, WATCHLIST_ROUTE_NAME);
              },
            ),
            const Divider(),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE_NAME);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
            'Ditonton ${_currentIndex == moviePageIndex ? 'Movie' : 'TV Series'}'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_ROUTE_NAME,
                  arguments: _currentIndex == moviePageIndex
                      ? SearchContext.movie
                      : SearchContext.tvSeries);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
