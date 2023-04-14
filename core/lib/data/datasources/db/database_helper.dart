import 'dart:async';
import 'package:core/common/encrypt.dart';
import 'package:core/data/models/movie/movie_table.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../models/tv_series/tv_series_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblMovieWatchlist = 'movie_watchlist';
  static const String _tblTvSeriesWatchlist = 'tv_series_watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('Your secure password...'),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblMovieWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE $_tblTvSeriesWatchlist (
          id INTEGER PRIMARY KEY,
          name TEXT,
          overview TEXT,
          posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblMovieWatchlist, movie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblMovieWatchlist);

    return results;
  }

  Future<int> saveTvSeriesWatchlist(TvSeriesModel tvSeriesModel) async {
    final db = await database;
    return await db!.insert(_tblTvSeriesWatchlist, tvSeriesModel.toJson());
  }

  Future<int> removeTvSeriesWatchlist(TvSeriesModel tvSeriesModel) async {
    final db = await database;
    return db!.delete(
      _tblTvSeriesWatchlist,
      where: 'id = ?',
      whereArgs: [tvSeriesModel.id],
    );
  }

  Future<Map<String, dynamic>?> getTvSeriesWatchlistStatus(int id) async {
    final db = await database;
    final result = await db!.query(
      _tblTvSeriesWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllWatchlistTVSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db!.query(_tblTvSeriesWatchlist);

    return result;
  }
}
