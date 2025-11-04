import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantmenuapp/data/models/cart_item_model.dart';
import 'package:restaurantmenuapp/data/models/item_model.dart';
import 'package:restaurantmenuapp/logic/cart_bloc/cart_bloc.dart';
import 'package:restaurantmenuapp/logic/cart_bloc/cart_event.dart';

class ItemTile extends StatelessWidget {
  final ItemModel item;
  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(width: 56, height: 56, child: Image.asset(item.image, fit: BoxFit.cover)),
      title: Text(item.name),
      subtitle: Text('\u20B9${item.price.toStringAsFixed(0)}'),
      trailing: ElevatedButton(
        onPressed: () {
           CartItemModel cartItem = CartItemModel(id: item.id, name: item.name, price: item.price, image: item.image, quantity: 1);
          context.read<CartBloc>().add(AddToCartEvent(cartItem));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${cartItem.name} Added to cart'),duration: Duration(microseconds: 500),  ));
        },
        child: const Text('Add'),
      ),
    );
  }
}