// TODO Implement this library.
import 'package:hive/hive.dart';

part 'category_hive_model.g.dart';

@HiveType(typeId: 0)
class CategoryHiveModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String imageUrl;

  @HiveField(3)
  String description;

  @HiveField(4)
  List<CategoryHiveModel>? subcategories;

  CategoryHiveModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    this.subcategories,
  });

  factory CategoryHiveModel.fromJson(Map<String, dynamic> json) {
    return CategoryHiveModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      imageUrl: json['image'] ?? '',
      description: json['description'] ?? '',
      subcategories:
          (json['subcategories'] as List?)
              ?.map((e) => CategoryHiveModel.fromJson(e))
              .toList(),
    );
  }
}
