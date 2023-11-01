part of 'wishlist_bloc.dart';

@immutable
class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistActionState extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistLoadedSuccessfulState extends WishlistState {
  final List<ProductModel> products;
  WishlistLoadedSuccessfulState({
    required this.products,
  });
}

class WishlistItemRemoveSuccessfulState extends WishlistState {
  final List<ProductModel> products;
  WishlistItemRemoveSuccessfulState({
    required this.products,
  });
}

class WishlistItemRemoveSuccessfulActionState extends WishlistActionState {}
