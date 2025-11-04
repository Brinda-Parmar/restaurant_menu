import 'package:equatable/equatable.dart';
import 'package:restaurantmenuapp/data/models/cart_item_model.dart';

abstract class CartEvent extends Equatable{
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCartEvent extends CartEvent{}

class AddToCartEvent extends CartEvent{
  final CartItemModel item;
  const AddToCartEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveFromCartEvent extends CartEvent{
  final int itemId;
  const RemoveFromCartEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class UpdateQuantityEvent extends CartEvent{
  final int itemId;
  final int quantity;
  const UpdateQuantityEvent(this.itemId, this.quantity);

  @override
  List<Object?> get props => [itemId, quantity];
}

class ClearCartEvent extends CartEvent{}