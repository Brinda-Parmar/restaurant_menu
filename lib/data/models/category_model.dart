import 'item_model.dart';

class CategoryModel {
  final String name;
  final List<ItemModel> items;

  CategoryModel({required this.name, required this.items});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    name: json['name'],
    items: (json['items'] as List).map((e) => ItemModel.fromJson(e)).toList(),
  );
}