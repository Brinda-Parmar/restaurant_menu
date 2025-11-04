class CartItemModel {
  final int id;
  final String name;
  final double price;
  final String image;
  int quantity;


  CartItemModel({required this.id, required this.name, required this.price, required this.image, required this.quantity});


  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'price': price,
    'image': image,
    'quantity': quantity,
  };


  factory CartItemModel.fromMap(Map<String, dynamic> map) => CartItemModel(
    id: map['id'] as int,
    name: map['name'] as String,
    price: (map['price'] as num).toDouble(),
    image: map['image'] as String,
    quantity: map['quantity'] as int,
  );
}