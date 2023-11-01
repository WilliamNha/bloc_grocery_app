import 'package:bloc_grocery_app/features/cart/bloc/cart_bloc.dart';
import 'package:bloc_grocery_app/features/cart/ui/product_widget_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartBloc = CartBloc();
  @override
  void initState() {
    super.initState();
    cartBloc.add(CartInitialFetchItemEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        title: const Text("Cart items"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        bloc: cartBloc,
        listener: (context, state) {
          if (state is CartItemRemoveSuccessActionState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Item removed from cart successfully.")));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartItemLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case CartItemLoadedSuccessState:
              final successState = state as CartItemLoadedSuccessState;
              return ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductWidgetCart(
                      cartBloc: cartBloc,
                      productDataModel: successState.products[index],
                    );
                  });
            case CartItemRemoveSuccessState:
              final successState = state as CartItemRemoveSuccessState;
              return ListView.builder(
                  itemCount: successState.cartItemproducts.length,
                  itemBuilder: (context, index) {
                    return ProductWidgetCart(
                      cartBloc: cartBloc,
                      productDataModel: successState.cartItemproducts[index],
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
