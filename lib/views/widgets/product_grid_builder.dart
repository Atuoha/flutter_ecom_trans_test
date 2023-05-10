import 'package:flutter/material.dart';
import 'package:shoe_stores/views/widgets/single_product_grid.dart';

import '../../controllers/route_manager.dart';
import '../../models/product.dart';
import '../../providers/cart.dart';
import '../../providers/category.dart';
import '../../providers/product.dart';

class ProductGridBuilder extends StatelessWidget {
  const ProductGridBuilder({
    Key? key,
    required this.products,
    required this.productsData,
    required this.categoryData,
    required this.cartData,
  }) : super(key: key);

  final List<Product> products;
  final Products productsData;
  final Categories categoryData;
  final Cart cartData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.only(top: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        crossAxisSpacing: 15,
      ),
      itemBuilder: (context, index) {
        Product item = products[index];
        return InkWell(
          onTap: () => Navigator.of(context).pushNamed(
            RouteManager.productDetails,
            arguments: {'product_id': item.id},
          ),
          child: SingleProductGrid(
            item: item,
            productsData: productsData,
            categoryData: categoryData,
            cartData: cartData,
          ),
        );
      },
    );
  }
}
