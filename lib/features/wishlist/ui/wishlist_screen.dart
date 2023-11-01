import 'package:bloc_grocery_app/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:bloc_grocery_app/features/wishlist/ui/product_widget_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final wishlistBloc = WishlistBloc();
  @override
  void initState() {
    super.initState();
    wishlistBloc.add(WishlistInitialFetchItem());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        title: const Text("Wishlist"),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        listener: (context, state) {
          if (state is WishlistItemRemoveSuccessfulActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Wishlist item removed.")));
          }
        },
        buildWhen: (previous, current) => current is! WishlistActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case WishlistLoadedSuccessfulState:
              final successState = state as WishlistLoadedSuccessfulState;
              return ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductWidgetWishlist(
                      wishlistBloc: wishlistBloc,
                      productDataModel: successState.products[index],
                    );
                  });
            case WishlistItemRemoveSuccessfulState:
              final successState = state as WishlistItemRemoveSuccessfulState;
              return ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductWidgetWishlist(
                      wishlistBloc: wishlistBloc,
                      productDataModel: successState.products[index],
                    );
                  });
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
