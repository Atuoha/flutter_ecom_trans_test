import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../models/product.dart';
import '../../providers/cart.dart';
import '../../providers/category.dart';
import '../../providers/product.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class SingleProductGrid extends StatelessWidget {
  const SingleProductGrid({
    Key? key,
    required this.item,
    required this.productsData,
    required this.categoryData,
    required this.cartData,
  }) : super(key: key);

  final Product item;
  final Products productsData;
  final Categories categoryData;
  final Cart cartData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Container(
            height: 105,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: imageBg,
            ),
            child: Image.asset(
              item.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            right: 5,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => productsData.toggleIsFavorite(item.id),
                  child: Icon(
                    item.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: item.isFavorite ? notifBg : iconColor,
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () => cartData.addItemToCart(
                      item.id, item.name, item.price, item.imageUrl),
                  child: Icon(
                    cartData.isItemOnCart(item.id)
                        ? Icons.shopping_bag
                        : Icons.shopping_bag_outlined,
                    color: cartData.isItemOnCart(item.id) ? notifBg : iconColor,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryData.findById(item.catId).title,
                  style: getRegularStyle(
                    color: greyFontColor,
                  ),
                ),
                // const SizedBox(height: 3),
                Text(
                  item.name,
                  style: getMediumStyle(
                    color: Colors.black87,
                    fontSize: FontSize.s14,
                  ),
                ),
                // const SizedBox(height: 25),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: starBg,
                  size: 15,
                ),
                const SizedBox(width: 3),
                Text(
                  '${item.rating} | ${item.soldNumber}',
                  style: getRegularStyle(
                    color: greyFontColor,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 5,
            child: Text(
              '\$${item.price}',
              style:
                  getMediumStyle(color: primaryColor, fontSize: FontSize.s16),
            ),
          ),
        ],
      ),
    );
  }
}
