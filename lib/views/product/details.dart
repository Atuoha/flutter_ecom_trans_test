import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_stores/resources/styles_manager.dart';
import '../../constants/color.dart';
import '../../controllers/route_manager.dart';
import '../../models/product.dart';
import '../../providers/cart.dart';
import '../../providers/category.dart';
import '../../providers/product.dart';
import '../../providers/reviews.dart';
import '../../providers/stores.dart';
import '../../resources/font_manager.dart';
import '../widgets/about_item_product_tab.dart';
import '../widgets/cart_icon.dart';
import '../widgets/product_details_bottom_sheet.dart';
import '../widgets/product_details_img_section.dart';
import '../widgets/review_item_product_tab.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  var currentImageIndex = 0; // for storing current index of the image
  TabController? _tabController;

  var currentReviewTag = 'Popular';
  List<String> reviewTags = ['Popular', 'Trending', 'Latest', 'Yesterday'];

  // change review tag
  void changeReviewTag(String value) {
    setState(() {
      currentReviewTag = value;
    });
  }

  // set image index
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
    var reviewData = Provider.of<Reviews>(context);
    Product product = productData.findById(id);
    List<Product> products =
        Provider.of<Products>(context, listen: false).recommendProducts;

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

    // navigate to store
    void navigateToStore() {
      Navigator.of(context).pushNamed(
        RouteManager.storeScreen,
        arguments: {'store_id': product.storeId},
      );
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
                height: size.height * 1.6,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // ABOUT PRODUCT TAB
                    AboutItemTab(
                      product: product,
                      categoryData: categoryData,
                      storeData: storeData,
                      size: size,
                      products: products,
                      productData: productData,
                      cartData: cartData,
                      navigateToStore: navigateToStore,
                    ),

                    // REVIEW TAB
                    reviewTab(
                      product: product,
                      size: size,
                      reviewData: reviewData,
                      currentReviewTag: currentReviewTag,
                      reviewTags: reviewTags,
                      changeReviewTag: changeReviewTag,
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
