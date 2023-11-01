import 'package:bloc_grocery_app/features/cart/ui/cart_screen.dart';
import 'package:bloc_grocery_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_grocery_app/features/home/ui/product_tile_widget.dart';
import 'package:bloc_grocery_app/features/wishlist/ui/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeBloc = HomeBloc();
  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialFetchProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) {
        return current is HomeActionState;
      },
      listener: (context, state) {
        if (state is HomeNavigateToCartScreenActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartScreen()));
        } else if (state is HomeNavigateToWishlistScreenActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishlistScreen()));
        } else if (state is ProductAddedToCartSuccessfullyState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 1),
              content: Text("Product added to cart successfully.")));
        } else if (state is ProductAddedToWishlistSuccessfullyState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 1),
              content: Text("Product added to wishlist successfully.")));
        }
      },
      buildWhen: (previous, current) {
        return current is! HomeActionState;
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.teal,
                  title: const Text("Shopping app"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeWishlistButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.favorite_border)),
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeCartButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.shopping_bag_outlined))
                  ],
                ),
                body: ListView.builder(
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                      homebloc: homeBloc,
                      productDataModel: successState.products[index],
                    );
                  },
                  itemCount: successState.products.length,
                ));
          case HomeErrorState:
            return const Scaffold(
              body: Center(child: Text("Error")),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
