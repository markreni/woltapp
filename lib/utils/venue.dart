class Venue {
  String id;
  String name;
  String description;
  String imageURL;
  int distance;
  double rating;

  Venue(this.id, this.name, this.description, this.imageURL, this.distance,
      this.rating);

  Venue.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        imageURL = json['image'],
        distance = json['distance'],
        rating = json['rating'];
}
