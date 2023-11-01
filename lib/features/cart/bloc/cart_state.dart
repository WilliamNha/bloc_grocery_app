part of 'cart_bloc.dart';

@immutable
class CartState {}

class CartInitial extends CartState {}

class CartActionState extends CartState {}

class CartItemLoadingState extends CartState {}

class CartItemLoadedSuccessState extends CartState {
  final List<ProductModel> products;
  CartItemLoadedSuccessState({
    required this.products,
  });
}

class CartItemRemoveSuccessState extends CartState {
  final List<ProductModel> cartItemproducts;
  CartItemRemoveSuccessState({
    required this.cartItemproducts,
  });
}

class CartItemRemoveSuccessActionState extends CartActionState {}
