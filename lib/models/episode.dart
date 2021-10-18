class Episode {
  String? id;
  String? name;
  String? number;
  String? season;
  String? image;
  String? summary;

  Episode({
    this.id,
    this.name,
    this.number,
    this.season,
    this.image,
    this.summary,
  });

  String getSummary() {
    if (summary == null || summary!.isEmpty) return '<h3>No summary</h3>';
    if (summary!.length > 50) return summary!.substring(0, 50);
    return summary!;
  }

  factory Episode.fromJson(Map<String, dynamic> json) {
    final image = json['image'] != null ? json['image']['medium'] : "";
    final episode = Episode(
      id: json['id'].toString(),
      name: json['name'],
      number: json['number'].toString(),
      season: json['season'].toString(),
      image: image,
      summary: json['summary'] ?? "",
    );
    return episode;
  }
}
