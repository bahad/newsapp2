import 'package:flutter/material.dart';
import 'package:newsapp2/core/init/cache/shared_preferences_config.dart';
import 'package:newsapp2/services/services.dart';
import '../../core/init/cache/sqflite_config.dart';

class NewsDetailProvider extends ChangeNotifier {
  dynamic newsDetail;
  String userID = "";
  var isLoading = false;
  bool isFav = false;
  DbHelper? dbHelper;

  getUserId() {
    userID = PreferenceUtils.getString("userId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  getFavMatch(String url, String userID) async {
    isFav = await dbHelper!.getFavoriteMatch(url, userID);
    notifyListeners();
  }

  NewsDetailProvider() {
    dbHelper = DbHelper();
  }

  Future getData(String url, String source) async {
    isLoading = true;
    if (source == "Haberler.com") {
      newsDetail = await Services().haberlercomDetail(url);
      isLoading = false;
    } else if (source == "Milliyet") {
      newsDetail = await Services().milliyetDetail(url);
      isLoading = false;
    } else if (source == "Tele1") {
      newsDetail = await Services().tele1Detail(url);
      isLoading = false;
    } else if (source == "Haber Global") {
      newsDetail = await Services().haberGlobalDetail(url);
      isLoading = false;
    } else if (source == "Sözcü") {
      newsDetail = await Services().sozcuDetail(url);
      isLoading = false;
    } else if (source == "Mynet") {
      newsDetail = await Services().mynetDetail(url);
      isLoading = false;
    } else if (source == "T24") {
      newsDetail = await Services().t24Detail(url);
      isLoading = false;
    }
    notifyListeners();
  }
}
