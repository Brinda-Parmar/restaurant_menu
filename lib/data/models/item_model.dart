class ItemModel {
  final int id;
  final String name;
  final double price;
  final String image;


  ItemModel({required this.id, required this.name, required this.price, required this.image});


  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    id: json['id'],
    name: json['name'],
    price: (json['price'] as num).toDouble(),
    image: json['image'],
  );
}