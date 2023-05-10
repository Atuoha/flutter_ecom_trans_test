import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shoe_stores/constants/enums/prod_location.dart';
import 'package:shoe_stores/views/widgets/product_grid_builder.dart';
import '../../constants/color.dart';
import '../../models/product.dart';
import '../../providers/cart.dart';
import '../../providers/category.dart';
import '../../providers/product.dart';
import '../../providers/stores.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import 'k_wrap.dart';

class AboutItemTab extends StatelessWidget {
  const AboutItemTab({
    Key? key,
    required this.product,
    required this.categoryData,
    required this.storeData,
    required this.size,
    required this.products,
    required this.productData,
    required this.cartData,
    required this.navigateToStore,
  }) : super(key: key);

  final Product product;
  final Categories categoryData;
  final Stores storeData;
  final Size size;
  final List<Product> products;
  final Products productData;
  final Cart cartData;
  final Function navigateToStore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KWrap(title: 'Brand', data: product.brandName),
              KWrap(title: 'Color', data: product.colorName),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KWrap(
                title: 'Category',
                data: categoryData.findById(product.catId).title,
              ),
              KWrap(title: 'Material', data: product.material),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KWrap(
                title: 'Condition',
                data: product.condition,
              ),
              KWrap(title: 'Heavy', data: product.heavy),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(
            color: storeColor,
            thickness: 0.4,
          ),
          const SizedBox(height: 30),
          Text(
            'Description:',
            style: getMediumStyle(
              color: accentColor,
              fontSize: FontSize.s16,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 140,
            child: ListView.builder(
              itemCount: product.descriptionList.length,
              itemBuilder: (context, index) {
                var item = product.descriptionList[index];

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    '• $item',
                    style: getRegularStyle(
                      color: greyFontColor,
                      fontSize: FontSize.s16,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ReadMoreText(
            product.description,
            trimLines: 2,
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more ⌄',
            trimExpandedText: 'Show less ^',
            style: getRegularStyle(
              color: greyFontColor,
              fontSize: FontSize.s16,
            ),
            lessStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            moreStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 30),
          const Divider(
            color: storeColor,
            thickness: 0.4,
          ),
          const SizedBox(height: 20),
          Text(
            'Shipping Information:',
            style: getMediumStyle(
              color: accentColor,
              fontSize: FontSize.s16,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KWrap(
                title: 'Delivery:',
                data: product.shippingInformation.delivery,
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KWrap(
                title: 'Shipping:',
                data: product.shippingInformation.shipping,
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KWrap(
                title: 'Arrival:',
                data: product.shippingInformation.arrival,
              )
            ],
          ),
          const SizedBox(height: 30),
          const Divider(
            color: storeColor,
            thickness: 0.4,
          ),
          const SizedBox(height: 30),
          Text(
            'Seller Information:',
            style: getMediumStyle(
              color: accentColor,
              fontSize: FontSize.s16,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: product.storeId,
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(
                    storeData.findById(product.storeId).imgUrl,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storeData.findById(product.storeId).name,
                    style: getMediumStyle(
                      color: accentColor,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Active 5m ago | 94.3 Positive feedback',
                    style: getRegularStyle(
                      color: greyFontColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      side: const BorderSide(color: primaryColor),
                    ),
                    onPressed: () => navigateToStore(),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(Icons.storefront, color: primaryColor),
                        const SizedBox(width: 10),
                        Text(
                          'Visit store',
                          style: getRegularStyle(
                            color: primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended Products:',
                style: getMediumStyle(
                  color: accentColor,
                  fontSize: FontSize.s16,
                ),
              ),
              TextButton(
                onPressed: () => {},
                child: Text(
                  'See more',
                  style: getMediumStyle(
                    color: primaryColor,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: size.height / 3,
            child: ProductGridBuilder(
              prodLocation: ProdLocation.recommendedProducts,
              products: products,
              productsData: productData,
              categoryData: categoryData,
              cartData: cartData,
            ),
          )
        ],
      ),
    );
  }


}
