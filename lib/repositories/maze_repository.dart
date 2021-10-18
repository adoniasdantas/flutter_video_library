import 'package:dio/dio.dart';
import 'package:flutter_video_library/models/episode.dart';
import 'package:flutter_video_library/models/person.dart';
import 'package:flutter_video_library/models/tv_show.dart';

class MazeRepository {
  static Future<List<TvShow>> searchTvShows(String searchText) async {
    final result =
        await Dio().get('https://api.tvmaze.com/search/shows?q=$searchText');
    if (result.statusCode == 200) {
      final data = result.data as List<dynamic>;
      List<TvShow> showList = [];
      for (var series in data) {
        final showMap = series['show'];
        final show = TvShow.fromJson(showMap);
        showList.add(show);
      }
      return showList;
    }
    return <TvShow>[];
  }

  static Future<TvShow> loadTvShowData(String id) async {
    try {
      final result =
          await Dio().get('https://api.tvmaze.com/shows/$id?embed=episodes');
      if (result.statusCode == 200) {
        final data = Map<String, dynamic>.from(result.data);
        final show = TvShow.withEpisodesFromJson(data);
        return show;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Episode> loadEpisodeData(String id) async {
    try {
      final result = await Dio().get('https://api.tvmaze.com/episodes/$id');
      if (result.statusCode == 200) {
        final data = Map<String, dynamic>.from(result.data);
        final episode = Episode.fromJson(data);
        return episode;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Person>> searchPeople(String searchText) async {
    final result =
        await Dio().get('https://api.tvmaze.com/search/people?q=$searchText');
    if (result.statusCode == 200) {
      final data = result.data as List<dynamic>;
      List<Person> peopleList = [];
      for (var series in data) {
        final personMap = series['person'] as Map<String, dynamic>;
        final person = Person.fromJson(personMap);
        peopleList.add(person);
      }
      return peopleList;
    }
    return <Person>[];
  }

  static Future<Person> loadPersonData(String id) async {
    try {
      final result = await Dio().get('https://api.tvmaze.com/people/$id');
      if (result.statusCode == 200) {
        final data = Map<String, dynamic>.from(result.data);
        final person = Person.fromJson(data);
        return person;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
