import 'package:flutter_video_library/models/tv_show.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteStorage {
  static Future<bool> addToFavorites(TvShow show) async {
    final storage = await SharedPreferences.getInstance();
    final result = await storage.setString(show.id!, show.toJson());
    return result;
  }

  static Future<bool> removeFromFavorites(String id) async {
    final storage = await SharedPreferences.getInstance();
    return await storage.remove(id);
  }

  static Future<bool> isFavorite(String id) async {
    final storage = await SharedPreferences.getInstance();
    return storage.containsKey(id);
  }

  static Future<Map<String, String>> loadFavorites() async {
    final storage = await SharedPreferences.getInstance();
    Map<String, String> favorites = {};
    for (var key in storage.getKeys()) {
      favorites.putIfAbsent(key, () => storage.getString(key)!);
    }
    return favorites;
  }
}
