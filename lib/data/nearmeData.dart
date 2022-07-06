class NearMe {
  String? image, title, description;
  double lat, long;
  NearMe({
    required this.image,
    required this.title,
    required this.description,
    required this.lat,
    required this.long,
  });
}

List<NearMe> nearMeData = [
  NearMe(
    image: "image",
    title: "title",
    description: "description",
    lat: 10,
    long: 10,
  ),
];
