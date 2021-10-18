import 'dart:convert';

import 'episode.dart';

class TvShow {
  String? id;
  String? name;
  String? poster;
  List<String>? days;
  String? time;
  List<String>? genres;
  String? summary;
  List<Episode>? episodes;

  TvShow({
    this.id,
    required this.name,
    this.poster,
    this.days,
    this.time,
    this.genres,
    this.summary,
    this.episodes,
  });

  String getSummary() {
    if (summary == null) return 'No summary';
    if (summary!.length > 50) return summary!.substring(0, 50);
    return summary!;
  }

  factory TvShow.fromJson(Map<String, dynamic> json) {
    final image = json['image'] != null
        ? (json['image'] as Map<String, dynamic>)['medium']
        : "";
    final show = TvShow(
      id: json['id'].toString(),
      name: json['name'],
      poster: image,
      days: (json['schedule']['days'] as List<dynamic>)
          .map((day) => day.toString())
          .toList(),
      time: json['schedule']['time'],
      genres: (json['genres'] as List<dynamic>)
          .map<String>((genre) => genre.toString())
          .toList(),
      summary: json['summary'],
    );
    return show;
  }

  factory TvShow.withEpisodesFromJson(Map<String, dynamic> json) {
    final show = TvShow.fromJson(json);
    show.episodes =
        (json['_embedded']['episodes'] as List<dynamic>).map((episode) {
      return Episode.fromJson(episode);
    }).toList();
    return show;
  }

  String toJson() {
    return jsonEncode({
      'name': name,
      'id': id,
      'poster': poster,
    });
  }
}
