class ServiceCategory {
  final int id;
  final String title;
  final String imageUrl;

  ServiceCategory({required this.id, required this.title, required this.imageUrl});

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'] ?? '', // Adjust if your API provides image
    );
  }
}