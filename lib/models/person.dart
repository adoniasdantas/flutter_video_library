class Person {
  String? id;
  String? name;
  String? image;
  String? country;
  String? birthday;

  Person({
    this.id,
    this.name,
    this.image,
    this.country,
    this.birthday,
  });

  String getBirthday() {
    if (birthday!.isEmpty) return 'Not available';
    return birthday!;
  }

  String getCountry() {
    if (country!.isEmpty) return 'Not available';
    return country!;
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    final image = json['image'] != null
        ? (json['image'] as Map<String, dynamic>)['medium']
        : "";
    final country = json['country'] != null
        ? (json['country'] as Map<String, dynamic>)['name']
        : "";
    final person = Person(
      name: json['name'],
      id: json['id'].toString(),
      image: image,
      country: country,
      birthday: json['birthday'] ?? "",
    );
    return person;
  }
}
