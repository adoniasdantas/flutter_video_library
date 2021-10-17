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
}
