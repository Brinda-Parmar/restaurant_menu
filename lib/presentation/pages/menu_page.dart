import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantmenuapp/logic/menu_bloc/menu_bloc.dart';
import 'package:restaurantmenuapp/logic/menu_bloc/menu_state.dart';
import 'package:restaurantmenuapp/presentation/widgets/appbar.dart';
import 'package:restaurantmenuapp/presentation/widgets/category_tile.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: commonAppBar(title: 'Menu',),
      body: BlocBuilder<MenuBloc, MenuState>(builder: (context, state) {
        if(state is MenuLoading){
          return const Center(child: CircularProgressIndicator(),);
        }
        else if(state is MenuLoaded){
          if(state.categories.isEmpty){
            return const Center(child: Text('No Menu Items Found'),);
          }else{
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final item = state.categories[index];
                return CategoryTile(category:item);
              },
            );
          }
        }
        else if(state is MenuError){
          return Center(child: Text(state.message, style: const TextStyle(color: Colors.red),),);
        }
        return const Center(child: Text('No data'));
      },),
    ));
  }
}