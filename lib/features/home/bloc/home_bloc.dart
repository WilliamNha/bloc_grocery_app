import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_grocery_app/data/cart_items.dart';
import 'package:bloc_grocery_app/data/grocery_data.dart';
import 'package:bloc_grocery_app/data/wishlist_item.dart';
import 'package:bloc_grocery_app/features/home/model/product_model.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialFetchProductEvent>(homeInitialFetchProductEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }
  FutureOr<void> homeInitialFetchProductEvent(
      HomeInitialFetchProductEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));

    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((e) => ProductModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
                imageUrl: e['imageUrl']))
            .toList()));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    debugPrint("wishlist clicked");
    wishlistItems.add(event.selectedProduct);
    emit(ProductAddedToWishlistSuccessfullyState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    debugPrint("cart clicked");
    cartItems.add(event.selectedProduct);
    emit(ProductAddedToCartSuccessfullyState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    debugPrint("wishlist clicked");
    emit(HomeNavigateToWishlistScreenActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    debugPrint("cart clicked");
    emit(HomeNavigateToCartScreenActionState());
  }
}
