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
}
