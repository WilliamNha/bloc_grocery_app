import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_grocery_app/data/cart_items.dart';
import 'package:bloc_grocery_app/features/home/model/product_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialFetchItemEvent>(cartInitialFetchItem);
    on<CartItemRemoveEvent>(cartItemRemoveEvent);
  }

  FutureOr<void> cartInitialFetchItem(
      CartInitialFetchItemEvent event, Emitter<CartState> emit) async {
    emit(CartItemLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(CartItemLoadedSuccessState(products: cartItems));
  }

  FutureOr<void> cartItemRemoveEvent(
      CartItemRemoveEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.removeProduct);
    emit(CartItemRemoveSuccessState(cartItemproducts: cartItems));
  }
}
