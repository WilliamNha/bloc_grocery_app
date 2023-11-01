import 'package:bloc_grocery_app/features/home/model/product_model.dart';
import 'package:bloc_grocery_app/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';

class ProductWidgetWishlist extends StatelessWidget {
  final WishlistBloc wishlistBloc;
  final ProductModel productDataModel;
  const ProductWidgetWishlist({
    super.key,
    required this.productDataModel,
    required this.wishlistBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(productDataModel.imageUrl),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              productDataModel.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(productDataModel.description),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productDataModel.price,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                IconButton(
                    onPressed: () {
                      wishlistBloc.add(
                          RemoveItemFromWishlist(product: productDataModel));
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
