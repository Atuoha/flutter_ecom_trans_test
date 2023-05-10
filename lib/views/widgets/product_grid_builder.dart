import 'package:flutter/material.dart';
import 'package:shoe_stores/views/widgets/single_product_grid.dart';

import '../../constants/enums/prod_location.dart';
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
    required this.prodLocation,
  }) : super(key: key);

  final List<Product> products;
  final Products productsData;
  final Categories categoryData;
  final Cart cartData;
  final ProdLocation prodLocation;

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
            arguments: {
              'product_id': item.id,
              'prodLocation': prodLocation,
            },
          ),
          child: SingleProductGrid(
            prodLocation: prodLocation,
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
