class Favorite {
  int? id;
  String? userId;
  String? image;
  String? title;
  String? time;
  String? subtitle;
  String? source;
  String? url;

  Favorite({
    this.image,
    this.userId,
    this.title,
    this.time,
    this.subtitle,
    this.source,
    this.url,
  });
  Favorite.withId({
    this.userId,
    this.id,
    this.image,
    this.title,
    this.time,
    this.subtitle,
    this.source,
    this.url,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map["id"] = id;
    }
    map["userId"] = userId;
    map["image"] = image;
    map["title"] = title;
    map["time"] = time;
    map["subtitle"] = subtitle;
    map["source"] = source;
    map["url"] = url;
    return map;
  }

  /* factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite.withId(
        id: map["id"],
        userID: map["userID"],
        placeID: map["placeID"],
        placeName: map["placeName"],
        placePhoto: map["placePhoto"],
        placeCountry: map["placeCountry"],
        placeProvince: map["placeProvince"]);
  } */
  Favorite.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    userId = map["userId"];
    image = map["image"];
    title = map["title"];
    time = map["time"];
    subtitle = map["subtitle"];
    source = map["source"];
    url = map["url"];
  }
}
