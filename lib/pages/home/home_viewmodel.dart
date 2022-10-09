import 'package:flutter/material.dart';
import 'package:newsapp2/services/services.dart';

import 'news_model.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  late final int a;
  int selectedCategoryIndex = 0;
  List<String> categoryTitles = ["Son Dakika", "Gündem", "Ekonomi", "Dünya"];
  bool autofocus = false;

  List<Result>? sonDakikaArr;
  List<Result>? gundemArr;
  List<Result>? ekonomiArr;
  List<Result>? dunyaArr;

  bool isSondakikaLoading = false;
  bool isGundemLoading = false;
  bool isEkonomiLoading = false;
  bool isDunyaLoading = false;

  bool isSearching = false;
  List? searchResult = [];

  HomeProvider() {
    getSondakika();
    getEkonomi();
    getGundem();
    getDunya();
  }

  updateCategoryIndex(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }

  Future getSondakika() async {
    isSondakikaLoading = true;
    await Services().getAllSondakika().then((value) {
      sonDakikaArr = value.result;
      isSondakikaLoading = false;
    });
    notifyListeners();
  }

  Future getGundem() async {
    isGundemLoading = true;
    await Services().getAllGundem().then((value) {
      gundemArr = value.result;
      isGundemLoading = false;
    });
    notifyListeners();
  }

  Future getEkonomi() async {
    isEkonomiLoading = true;
    await Services().getAllEkonomi().then((value) {
      ekonomiArr = value.result;
      isEkonomiLoading = false;
    });
    notifyListeners();
  }

  Future getDunya() async {
    isEkonomiLoading = true;
    await Services().getAllDunya().then((value) {
      dunyaArr = value.result;
      isEkonomiLoading = false;
    });
    notifyListeners();
  }

  onSearchTextChanged(String text) async {
    searchResult?.clear();
    if (text.isEmpty) {
      autofocus = false;
      notifyListeners();
      return;
    }

    autofocus = true;
    notifyListeners();
    sonDakikaArr?.forEach((element) {
      if (element.title!.toLowerCase().contains(text.toLowerCase())) {
        searchResult?.add(element);
        notifyListeners();
      }
    });
    gundemArr?.forEach((element) {
      if (element.title!.toLowerCase().contains(text.toLowerCase())) {
        searchResult?.add(element);
        notifyListeners();
      }
    });
    ekonomiArr?.forEach((element) {
      if (element.title!.toLowerCase().contains(text.toLowerCase())) {
        searchResult?.add(element);
        notifyListeners();
      }
    });
    dunyaArr?.forEach((element) {
      if (element.title!.toLowerCase().contains(text.toLowerCase())) {
        searchResult?.add(element);
        notifyListeners();
      }
    });

    notifyListeners();
  }

  void startSearch(BuildContext context) {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: () {
      searchController.clear();
      onSearchTextChanged("");
      isSearching = false;
      notifyListeners();
    }));
    isSearching = true;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
