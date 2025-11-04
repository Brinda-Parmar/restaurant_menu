import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantmenuapp/logic/menu_bloc/menu_event.dart';
import 'package:restaurantmenuapp/logic/menu_bloc/menu_state.dart';


import '../../data/models/category_model.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState>{
  MenuBloc() : super(MenuInitial()){
    on<LoadMenuEvent>(_onLoadMenu);

  }

  Future<void> _onLoadMenu(LoadMenuEvent event, Emitter<MenuState> emit) async {
    emit(MenuLoading());

    try{
      final data  = await rootBundle.loadString('lib/data/local/menu.json');
     final jsonData = jsonDecode(data);
     final categories = (jsonData['categories'] as List).map((e) => CategoryModel.fromJson(e)).toList();
     emit(MenuLoaded(categories));
    }catch(e,x){
      print("menu exception ---$e at $x");
      emit(MenuError("Failed to load menu"));
    }
  }



}