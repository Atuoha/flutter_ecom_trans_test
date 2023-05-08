import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';
import 'package:shoe_stores/resources/styles_manager.dart';

import '../../constants/color.dart';
import '../../models/product.dart';
import '../../providers/cart.dart';
import '../../providers/product.dart';
import '../../providers/stores.dart';
import '../../resources/font_manager.dart';
import '../widgets/cart_icon.dart';
import '../widgets/product_details_bottom_sheet.dart';
import '../widgets/product_details_img_section.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> {
  var currentImageIndex = 0;

  void setImageIndex(int index) {
    setState(() {
      currentImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String id = data['product_id'];
    var productData = Provider.of<Products>(context);
    var storeData = Provider.of<Stores>(context);
    var cartData = Provider.of<Cart>(context);
    Product product = productData.findById(id);

    void addToCart() {
      cartData.addItemToCart(
        product.id,
        product.name,
        product.price,
        product.imageUrl,
      );
    }

    void buyNow() {
      // Todo:
      // Implement buyNow
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.chevron_left, color: iconColor),
            );
          },
        ),
        actions: [
          GestureDetector(
            onTap: () => productData.toggleIsFavorite(product.id),
            child: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: product.isFavorite ? notifBg : iconColor,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.share_outlined, color: iconColor),
          const CartIcon(),
          const SizedBox(width: 18),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productDetailsImageSection(
              size,
              product,
              currentImageIndex,
              setImageIndex,
            ),
            const SizedBox(height: 15),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(Icons.storefront, color: storeColor),
                const SizedBox(width: 10),
                Text(
                  storeData.findById(product.storeId).name,
                  style: getRegularStyle(color: storeColor),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: getMediumStyle(
                color: accentColor,
                fontSize: FontSize.s20,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      color: starBg,
                      // size: 15,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${product.rating} Ratings',
                      style: getRegularStyle(
                        color: greyFontColor,
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize.s16,
                      ),
                    ),
                  ],
                ),
                Text(
                  '•',
                  style: getRegularStyle(
                    color: greyFontColor,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.s25,
                  ),
                ),
                Text(
                  '${product.reviews.length}k Reviews',
                  style: getRegularStyle(
                    color: greyFontColor,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.s16,
                  ),
                ),
                Text(
                  '•',
                  style: getRegularStyle(
                    color: greyFontColor,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.s25,
                  ),
                ),
                Text(
                  '${product.soldNumber}k Sold',
                  style: getRegularStyle(
                    color: greyFontColor,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.s16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomSheet: ProductDetailsBottomSheet(
        product: product,
        cartData: cartData,
        addToCart: addToCart,
        buyNow: buyNow,
      ),
    );
  }
}
