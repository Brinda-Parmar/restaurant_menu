import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantmenuapp/core/themes/light_theme.dart';
import 'package:restaurantmenuapp/data/models/cart_item_model.dart';
import 'package:restaurantmenuapp/logic/cart_bloc/cart_bloc.dart';
import 'package:restaurantmenuapp/logic/cart_bloc/cart_event.dart';
import 'package:restaurantmenuapp/logic/cart_bloc/cart_state.dart';
import 'package:restaurantmenuapp/presentation/widgets/appbar.dart';

import 'order_confirmation_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: commonAppBar(title: "Cart"),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              if (state.items.isEmpty) {
                return const Center(child: Text("No Items in Cart"));
              }
              else {
                List<CartItemModel> items = state.items;
                final cartBloc = context.read<CartBloc>();
                final subTotal = cartBloc.subtotal(items);
                final tax = cartBloc.tax(items);
                final total = cartBloc.total(items);
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return ListTile(
                            leading: SizedBox(
                              width: 60,
                              height: 60,
                              child: Image.asset(item.image, fit: BoxFit.cover),
                            ),
                            title: Text(item.name),
                            subtitle: Text("Qty : ${item.quantity}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    context.read<CartBloc>().add(
                                      UpdateQuantityEvent(
                                        item.id,
                                        item.quantity - 1,
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => context.read<CartBloc>().add(
                                    UpdateQuantityEvent(
                                      item.id,
                                      item.quantity + 1,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => context.read<CartBloc>().add(
                                    RemoveFromCartEvent(item.id),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      color: lightTheme.highlightColor,
                      width: screenWidth,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Subtotal: ₹${subTotal.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Tax: ₹${tax.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Total: ₹${total.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<CartBloc>().add(ClearCartEvent());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(20),
                            width: screenWidth / 2,
                            color: lightTheme.primaryColor,
                            child: const Text(
                              'Clear Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: items.isEmpty
                              ? null
                              : () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          OrderConfirmationPage(items: items),
                                    ),
                                  );
                                },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(20),
                            width: screenWidth / 2,
                            color: lightTheme.primaryColor,
                            child: const Text(
                              'Place Order',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            }
            return const Center(child: Text('No items'));
          },
        ),
      ),
    );
  }
}
