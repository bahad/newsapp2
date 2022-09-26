import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp2/core/init/cache/shared_preferences_config.dart';
import 'package:newsapp2/core/init/cache/sqflite_config.dart';
import 'package:newsapp2/pages/favorites/favorites_model.dart';

class FavoritesProvider extends ChangeNotifier {
  DbHelper? dbHelper = DbHelper();
  String userID = "";
  var isLoading = false;
  int? isDeleted = 0;
  List<Favorite>? favorite;

  getUserId() {
    PreferenceUtils.init();
    userID = PreferenceUtils.getString("userId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  getFav() async {
    isLoading = true;
    favorite = await dbHelper?.getFavoritebyUserId(userID);
    isLoading = false;
    notifyListeners();
  }

  deleteFav(String url, String userId) async {
    isDeleted = await dbHelper?.removeFavorite(url, userId);
    notifyListeners();
    if (kDebugMode) {
      print(isDeleted);
    }
  }
}
