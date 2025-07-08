// TODO Implement this library.
class PackageService {
  final int id;
  final String name;
  final String price;
  final String? duration;
  final String? rating;
  final String description;
  final String image;
  final List<String> features;
  final String slug;

  PackageService({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.rating,
    required this.description,
    required this.image,
    required this.features,
    required this.slug,
  });

  factory PackageService.fromJson(Map<String, dynamic> json) {
    return PackageService(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      duration: json['duration'],
      rating: json['rating']?.toString(),
      description: json['description'],
      image: json['image'],
      features: List<String>.from(json['features'] ?? []),
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'duration': duration,
    'rating': rating,
    'description': description,
    'image': image,
    'features': features,
    'slug': slug,
  };
}