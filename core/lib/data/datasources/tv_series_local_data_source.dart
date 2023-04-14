import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/tv_series/tv_series_model.dart';
import 'package:core/utils/exception.dart';

import '../../domain/entities/tv_series.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> saveWatchlist(TvSeriesModel tvSeriesModel);
  Future<String> removeWatchlist(TvSeriesModel tvSeriesModel);
  Future<TvSeriesModel?> getWatchlistStatus(int id);
  Future<List<TvSeriesModel>> getAllWatchlistTvSeries();
}

class TvSeriesDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<TvSeriesModel>> getAllWatchlistTvSeries() async {
    final result = await databaseHelper.getAllWatchlistTVSeries();

    return result.map((data) => TvSeriesModel.fromJson(data)).toList();
  }

  @override
  Future<TvSeriesModel?> getWatchlistStatus(int id) async {
    final result = await databaseHelper.getTvSeriesWatchlistStatus(id);
    if (result != null) {
      return TvSeriesModel.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<String> removeWatchlist(TvSeriesModel tvSeriesModel) async {
    try {
      await databaseHelper.removeTvSeriesWatchlist(tvSeriesModel);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> saveWatchlist(TvSeriesModel tvSeriesModel) async {
    try {
      await databaseHelper.saveTvSeriesWatchlist(tvSeriesModel);
      return 'Saved to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
