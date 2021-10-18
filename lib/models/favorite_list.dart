import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../external/favorite_storage.dart';
import 'tv_show.dart';

class FavoriteList extends ChangeNotifier {
  static Map<String, String> _tvShows = {};

  UnmodifiableMapView<String, String> get tvShows =>
      UnmodifiableMapView(_tvShows);

  static Future<void> loadFavoritesTvShows() async {
    _tvShows = await FavoriteStorage.loadFavorites();
  }

  Future<void> addToFavorites(TvShow show) async {
    if (await FavoriteStorage.addToFavorites(show)) {
      _tvShows.putIfAbsent(show.id!, () => show.toJson());
      notifyListeners();
    }
  }

  Future<void> removeFromFavorites(String id) async {
    if (await FavoriteStorage.removeFromFavorites(id)) {
      _tvShows.remove(id);
      notifyListeners();
    }
  }
}
