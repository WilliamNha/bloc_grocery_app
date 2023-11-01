part of 'wishlist_bloc.dart';

@immutable
class WishlistEvent {}

class WishlistInitialFetchItem extends WishlistEvent {}

class RemoveItemFromWishlist extends WishlistEvent {
  final ProductModel product;
  RemoveItemFromWishlist({
    required this.product,
  });
}
