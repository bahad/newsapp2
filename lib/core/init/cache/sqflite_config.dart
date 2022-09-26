// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../pages/favorites/favorites_model.dart';

class DbHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    var dbFolder = await getDatabasesPath();
    String path = join(dbFolder, "Favorite.db");

    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    return await db.execute(
        "CREATE TABLE Favorite(id INTEGER PRIMARY KEY, image TEXT, title TEXT, time TEXT, subtitle TEXT, source TEXT, url TEXT, userId )");
  }

  Future<List<Favorite>> getFavorite() async {
    var dbClient = await db;
    var result = await dbClient.query("Favorite", orderBy: "title");
    return result.map((data) => Favorite.fromMap(data)).toList();
  }

  Future<List<Favorite>> getFavoritebyUserId(userId) async {
    var dbClient = await db;
    var result = await dbClient.query("Favorite",
        where: "userId=?", orderBy: "title", whereArgs: [userId]);

    return result.map((data) => Favorite.fromMap(data)).toList();
  }

  //GET IF DATA MATCH
  Future<bool> getFavoriteMatch(url, userId) async {
    var dbClient = await db;
    var result = await dbClient.query("Favorite",
        where: "url=? and userId=?",
        orderBy: "title",
        whereArgs: [url, userId]);
    if (result.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> insertFavorite(Favorite favorite) async {
    var dbClient = await db;
    return await dbClient.insert("Favorite", favorite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.fail);
  }

  Future<int> removeFavorite(String url, String userId) async {
    var dbClient = await db;
    return await dbClient.delete("Favorite",
        where: "url=? and userId=?", whereArgs: [url, userId]);
  }
}
