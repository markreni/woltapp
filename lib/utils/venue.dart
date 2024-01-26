class Venue {
  String id;
  String name;
  String description;
  String imageURL;

  Venue(this.id, this.name, this.description, this.imageURL);

  Venue.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        imageURL = json['image'];
}
