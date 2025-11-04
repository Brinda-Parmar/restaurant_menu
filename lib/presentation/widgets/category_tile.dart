import 'package:flutter/material.dart';
import 'package:restaurantmenuapp/data/models/category_model.dart';
import 'package:restaurantmenuapp/presentation/widgets/item_tile.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        //initiallyExpanded: true,
        title: Text(category.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: category.items.map((item) => ItemTile(item: item)).toList(),
      ),
    );
  }
}