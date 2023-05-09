import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_stores/resources/styles_manager.dart';
import '../../constants/color.dart';
import '../../models/product.dart';
import '../../providers/cart.dart';
import '../../providers/category.dart';
import '../../providers/product.dart';
import '../../providers/stores.dart';
import '../../resources/font_manager.dart';
import '../widgets/cart_icon.dart';
import '../widgets/k_wrap.dart';
import '../widgets/product_details_bottom_sheet.dart';
import '../widgets/product_details_img_section.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  var currentImageIndex = 0; // for storing current index of the image
  TabController? _tabController;

  void setImageIndex(int index) {
    setState(() {
      currentImageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
    var categoryData = Provider.of<Categories>(context);
    Product product = productData.findById(id);

    // add to cart
    void addToCart() {
      cartData.addItemToCart(
        product.id,
        product.name,
        product.price,
        product.imageUrl,
      );
    }

    // remove from cart
    void removeFromCart() {
      cartData.removeFromCart(product.id);
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
            // toggling isFavorite from product provider
            child: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: product.isFavorite ? notifBg : iconColor,
              size: 30,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(
            Icons.share_outlined,
            color: iconColor,
            size: 30,
          ),
          const SizedBox(width: 10),
          const CartIcon(),
          const SizedBox(width: 18),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
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
              ),
              const SizedBox(height: 15),
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'About Item'),
                  Tab(text: 'Reviews'),
                ],
                unselectedLabelColor: greyFontColor,
                indicatorColor: primaryColor,
                labelColor: primaryColor,
                labelStyle: const TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: size.height / 1,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Widgets for the first tab go here
                    Padding(
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
                                data:
                                    categoryData.findById(product.catId).title,
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
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
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
                        ],
                      ),
                    ),

                    // Widgets for the second tab go here
                    SizedBox(
                      child: Column(
                        children: [
                          Center(
                            child: Text('Tab 2 Content'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: ProductDetailsBottomSheet(
        product: product,
        cartData: cartData,
        addToCart: addToCart,
        removeFromCart: removeFromCart,
      ),
    );
  }
}
