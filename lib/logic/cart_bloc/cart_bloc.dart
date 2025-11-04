import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantmenuapp/core/constants/AppConstants.dart';
import 'package:restaurantmenuapp/data/models/cart_item_model.dart';
import 'package:restaurantmenuapp/data/services/database_service.dart';
import 'package:restaurantmenuapp/logic/cart_bloc/cart_event.dart';
import 'package:restaurantmenuapp/logic/cart_bloc/cart_state.dart';


class CartBloc extends Bloc<CartEvent, CartState>{
  final DatabaseService _db = DatabaseService();

  CartBloc() : super(CartInitial()){
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateQuantityEvent>(_onUpdateQuantity);
    on<ClearCartEvent>(_onClearCart);
  }

  void _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final items = await _db.getCartItems();
    emit(CartLoaded(items));
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    List<CartItemModel> current = state is CartLoaded ? List<CartItemModel>.from((state as CartLoaded).items) : <CartItemModel>[];

    final idx = current.indexWhere((e) => e.id == event.item.id);

    if(idx >=0){
      current[idx].quantity += event.item.quantity;
    }else {
      current.add(event.item);
    }

    for( var item in current){
      await _db.insertUpdateCartItem(item);
    }


    emit(CartLoaded(List.from(current)));
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    List<CartItemModel> current = state is CartLoaded
        ? List<CartItemModel>.from((state as CartLoaded).items)
        : await _db.getCartItems();

    current.removeWhere((item) => item.id == event.itemId);

    await _db.deleteCartItem(event.itemId);

    final newList = await _db.getCartItems();
    emit(CartLoaded(List<CartItemModel>.from(newList)));
  }

  void _onUpdateQuantity(UpdateQuantityEvent event, Emitter<CartState> emit) async {
    List<CartItemModel> current = state is CartLoaded
        ? List<CartItemModel>.from((state as CartLoaded).items)
        : await _db.getCartItems();

    final idx = current.indexWhere((e) => e.id == event.itemId);

    if (idx >= 0) {
      current[idx].quantity = event.quantity;

      if (event.quantity <= 0) {
        current.removeAt(idx);
        await _db.deleteCartItem(event.itemId);
      } else {
        await _db.insertUpdateCartItem(current[idx]);
      }
    }

    final newList = await _db.getCartItems();
    emit(CartLoaded(List<CartItemModel>.from(newList)));
  }


  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) async {
    await _db.clearCart();
    emit(CartLoaded([]));
  }

  double subtotal(List<CartItemModel> items) => items.fold(0, (p, e) => p + e.price * e.quantity);
  double tax(List<CartItemModel> items) => subtotal(items) * AppConstants.taxPercent;
  double total(List<CartItemModel> items) => subtotal(items) + tax(items);


}
