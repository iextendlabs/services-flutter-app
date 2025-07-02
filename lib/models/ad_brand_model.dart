class Ad {
  final String title;
  final String details;
  final String imageUrl;

  Ad({required this.title, required this.details, required this.imageUrl});

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    title: json['title'] ?? '',
    details: json['details'] ?? '',
    imageUrl: json['image'] ?? '',
  );
}

class Brand {
  final String name;
  final String imageUrl;
  final String link;

  Brand({required this.name, required this.imageUrl, required this.link});

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    name: json['name'] ?? '',
    imageUrl: json['image'] ?? '',
    link: json['link'] ?? '',
  );
}