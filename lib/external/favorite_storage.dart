import 'package:flutter_video_library/models/tv_show.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteStorage {
  static Future<bool> addToFavorites(TvShow show) async {
    final storage = await SharedPreferences.getInstance();
    final result = await storage.setString(show.id!, show.name!);
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

  static Future<List<String>> loadFavorites() async {
    final storage = await SharedPreferences.getInstance();
    return storage.getKeys().map((key) => key).toList();
  }
}
