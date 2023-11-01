part of 'home_bloc.dart';

@immutable
class HomeEvent {}

class HomeInitialFetchProductEvent extends HomeEvent {}

class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  final ProductModel selectedProduct;
  HomeProductWishlistButtonClickedEvent({
    required this.selectedProduct,
  });
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductModel selectedProduct;
  HomeProductCartButtonClickedEvent({
    required this.selectedProduct,
  });
}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}
