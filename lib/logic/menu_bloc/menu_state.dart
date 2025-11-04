import 'package:equatable/equatable.dart';
import 'package:restaurantmenuapp/data/models/category_model.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object?> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<CategoryModel> categories;
  const MenuLoaded(this.categories);

  @override
  List<Object?> get props => [categories];

}

class MenuError extends MenuState {
  final String message;
  const MenuError(this.message);

  @override
  List<Object?> get props => [message];
}
