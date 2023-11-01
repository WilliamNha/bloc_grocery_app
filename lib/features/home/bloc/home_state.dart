part of 'home_bloc.dart';

@immutable
class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductModel> products;
  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

//navigate to is action state
class HomeNavigateToWishlistScreenActionState extends HomeActionState {}

class HomeNavigateToCartScreenActionState extends HomeActionState {}

class ProductAddedToWishlistSuccessfullyState extends HomeActionState {}

class ProductAddedToCartSuccessfullyState extends HomeActionState {}
