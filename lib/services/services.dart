import 'package:flutter/material.dart';
import 'package:newsapp2/pages/newsdetail/newsdetail_model.dart';
import '../pages/home/news_model.dart';
import '../core/init/network/network_manager.dart';

class Services {
  final BuildContext? context;
  Services({this.context});
  Future<NewsModel> getAllDunya() async {
    return await NetworkManager.instance.get<NewsModel>(
      path: "/haberler/getalldunya",
      model: NewsModel(),
      context: context,
    );
  }

  Future<NewsModel> getAllEkonomi() async {
    return await NetworkManager.instance.get<NewsModel>(
      path: "/haberler/getallekonomi",
      model: NewsModel(),
      context: context,
    );
  }

  Future<NewsModel> getAllSondakika() async {
    return await NetworkManager.instance.get<NewsModel>(
      path: "/haberler/getallsondakika",
      model: NewsModel(),
      context: context,
    );
  }

  Future<NewsModel> getAllGundem() async {
    return await NetworkManager.instance.get<NewsModel>(
      path: "/haberler/getallgundem",
      model: NewsModel(),
      context: context,
    );
  }

  static const haberlercom = 'haberDetay';
  static const milliyet = 'milliyetDetay';
  static const t24 = 't24Detay';
  static const haberGlobal = 'haberGlobalDetay';
  static const tele1 = 'tele1Detay';
  static const sozcu = "sozcuDetay";
  static const sonDakika = "sondakikacomDetay";
  static const mynet = "mynetDetay";

  Future<dynamic> haberlercomDetail(String url) async {
    return await NetworkManager.instance.get<NewsDetailModel>(
      path: "/haberler/$haberlercom/$url",
      model: NewsDetailModel(),
      context: context,
    );
  }

  Future<dynamic> t24Detail(String url) async {
    return await NetworkManager.instance.get<NewsDetailModel>(
      path: "/haberler/$t24/$url",
      model: NewsDetailModel(),
      context: context,
    );
  }

  Future<dynamic> sondakikaDetail(String url) async {
    return await NetworkManager.instance.get<NewsDetailModel>(
      path: "/haberler/$sonDakika/$url",
      model: NewsDetailModel(),
      context: context,
    );
  }

  Future<dynamic> haberGlobalDetail(String url) async {
    return await NetworkManager.instance.get<NewsDetailModel>(
      path: "/haberler/$haberGlobal/$url",
      model: NewsDetailModel(),
      context: context,
    );
  }

  Future<dynamic> tele1Detail(String url) async {
    return await NetworkManager.instance.get<NewsDetailModel>(
      path: "/haberler/$tele1/$url",
      model: NewsDetailModel(),
      context: context,
    );
  }

  Future<dynamic> mynetDetail(String url) async {
    return await NetworkManager.instance.get<NewsDetailModel>(
      path: "/haberler/$mynet/$url",
      model: NewsDetailModel(),
      context: context,
    );
  }

  Future<dynamic> sozcuDetail(String url) async {
    return await NetworkManager.instance.get<NewsDetailModel>(
      path: "/haberler/$sozcu/$url",
      model: NewsDetailModel(),
      context: context,
    );
  }

  Future<dynamic> milliyetDetail(String url) async {
    return await NetworkManager.instance.get<NewsDetailModel>(
      path: "/haberler/$milliyet/$url",
      model: NewsDetailModel(),
      context: context,
    );
  }
}
