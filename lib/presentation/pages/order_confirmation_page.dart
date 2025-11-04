import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantmenuapp/core/themes/light_theme.dart';
import 'package:restaurantmenuapp/data/models/cart_item_model.dart';
import 'package:restaurantmenuapp/logic/cart_bloc/cart_bloc.dart';
import 'package:restaurantmenuapp/logic/cart_bloc/cart_state.dart';
import 'package:restaurantmenuapp/presentation/widgets/appbar.dart';

class OrderConfirmationPage extends StatelessWidget {
  final List<CartItemModel> items;

  const OrderConfirmationPage({super.key, required this.items});

  String calculateEstimateTime(List<CartItemModel> items) {
    int totalQty = items.fold(0, (sum, item) => sum + item.quantity);
    int time = 20 + (totalQty * 5);

    if (time <= 60) {
      return "$time";
    }

    int hours = time ~/ 60;
    int minutes = time % 60;

    if (minutes == 0) {
      return "$hours hour";
    } else {
      return "$hours hour $minutes";
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final kot = DateTime.now().millisecondsSinceEpoch;
    return SafeArea(child: Scaffold(
      appBar: commonAppBar(title: "Order Confirmation",),
      body: BlocBuilder<CartBloc, CartState>(

        builder:(context, state) {
          final items = (context.read<CartBloc>().state as CartLoaded).items;
          final estTime =calculateEstimateTime(items);

          return Padding(padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("KOT: $kot", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Text(
                  "Estimated Delivery Time",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "$estTime minutes",
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              const SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text("Quantity: ${item.quantity}"),
                      trailing: Text("₹${item.price * item.quantity}"),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      width: screenWidth,
                      color: lightTheme.primaryColor,
                      child: const Text('Confirm Order',  style: TextStyle(color: Colors.white, fontSize: 18),)),
                ),
            ],),
          );
        }
      ),

    ));
  }
}
