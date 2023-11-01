part of 'cart_bloc.dart';

@immutable
class CartEvent {}

class CartInitialFetchItemEvent extends CartEvent {}

class CartItemRemoveEvent extends CartEvent {
  final ProductModel removeProduct;
  CartItemRemoveEvent({
    required this.removeProduct,
  });
}
