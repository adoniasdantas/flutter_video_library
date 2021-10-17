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
}
