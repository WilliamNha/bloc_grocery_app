import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_grocery_app/data/wishlist_item.dart';
import 'package:bloc_grocery_app/features/home/model/product_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialFetchItem>(wishlistInitialFetchItem);
    on<RemoveItemFromWishlist>(removeItemFromWishlist);
  }

  FutureOr<void> wishlistInitialFetchItem(
      WishlistInitialFetchItem event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(WishlistLoadedSuccessfulState(products: wishlistItems));
  }

  FutureOr<void> removeItemFromWishlist(
      RemoveItemFromWishlist event, Emitter<WishlistState> emit) async {
    wishlistItems.remove(event.product);
    WishlistInitialFetchItem();
    emit(WishlistItemRemoveSuccessfulState(products: wishlistItems));
    emit(WishlistItemRemoveSuccessfulActionState());
  }
}
