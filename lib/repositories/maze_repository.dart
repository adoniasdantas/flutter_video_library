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
        final image = showMap['image'] != null
            ? (showMap['image'] as Map<String, dynamic>)['medium']
            : "";
        final show = TvShow(
          id: showMap['id'].toString(),
          name: showMap['name'],
          poster: image,
          days: (showMap['schedule']['days'] as List<dynamic>)
              .map((day) => day.toString())
              .toList(),
          time: showMap['schedule']['time'],
          genres: (showMap['genres'] as List<dynamic>)
              .map<String>((genre) => genre.toString())
              .toList(),
          summary: showMap['summary'],
        );
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
        final poster = data['image'] != null
            ? (data['image'] as Map<String, dynamic>)['medium']
            : "";
        final show = TvShow(
          name: data['name'],
          id: id,
          poster: poster,
          genres: (data['genres'] as List<dynamic>)
              .map<String>((genre) => genre.toString())
              .toList(),
          summary: data['summary'],
          days: (data['schedule']['days'] as List<dynamic>)
              .map((day) => day.toString())
              .toList(),
          time: data['schedule']['time'],
          episodes:
              (data['_embedded']['episodes'] as List<dynamic>).map((episode) {
            final episodeData = episode as Map<String, dynamic>;
            final image = episodeData['image'] != null
                ? episodeData['image']['medium']
                : "";

            return Episode(
              id: episodeData['id'].toString(),
              name: episodeData['name'],
              number: episodeData['number'].toString(),
              season: episodeData['season'].toString(),
              image: image,
              summary: episodeData['summary'] ?? "",
            );
          }).toList(),
        );
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
        final image = data['image'] != null ? data['image']['medium'] : "";
        final episode = Episode(
          name: data['name'],
          number: data['number'].toString(),
          season: data['season'].toString(),
          image: image,
          summary: data['summary'] ?? "",
        );
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
        final image = personMap['image'] != null
            ? (personMap['image'] as Map<String, dynamic>)['medium']
            : "";
        final country = personMap['country'] != null
            ? (personMap['country'] as Map<String, dynamic>)['name']
            : "";
        final person = Person(
          id: personMap['id'].toString(),
          name: personMap['name'],
          image: image,
          country: country,
          birthday: personMap['birthday'] ?? "",
        );
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
        final image = data['image'] != null
            ? (data['image'] as Map<String, dynamic>)['medium']
            : "";
        final country = data['country'] != null
            ? (data['country'] as Map<String, dynamic>)['name']
            : "";
        final person = Person(
          name: data['name'],
          id: id,
          image: image,
          country: country,
          birthday: data['birthday'] ?? "",
        );
        return person;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
