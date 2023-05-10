import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shoe_stores/resources/assets_manager.dart';
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
import '../widgets/cart_icon.dart';
import '../widgets/k_wrap.dart';
import '../widgets/product_details_bottom_sheet.dart';
import '../widgets/product_details_img_section.dart';
import 'package:readmore/readmore.dart';

import '../widgets/product_grid_builder.dart';
import '../widgets/rating_item.dart';
import '../widgets/review_chip.dart';

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
                                        side: const BorderSide(
                                            color: primaryColor)),
                                    onPressed: () => navigateToStore(),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        const Icon(Icons.storefront,
                                            color: primaryColor),
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
                              products: products,
                              productsData: productData,
                              categoryData: categoryData,
                              cartData: cartData,
                            ),
                          )
                        ],
                      ),
                    ),

                    // REVIEW TAB
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Review & Ratings:',
                            style: getMediumStyle(
                              color: accentColor,
                              fontSize: FontSize.s16,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                    children: [
                                      Text(
                                        product.rating.toString(),
                                        style: getBoldStyle(
                                          color: accentColor,
                                          fontSize: FontSize.s50,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '/ 5.0',
                                        style: getRegularStyle(
                                          color: greyFontColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  RatingBar(
                                    initialRating: product.rating,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemSize: 20,
                                    itemCount: 5,
                                    ratingWidget: RatingWidget(
                                      full: Image.asset(AssetManager.fullStar),
                                      half: Image.asset(AssetManager.halfStar),
                                      empty:
                                          Image.asset(AssetManager.emptyStar),
                                    ),
                                    itemPadding:
                                        const EdgeInsets.only(right: 1.0),
                                    onRatingUpdate: (double value) {},
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    '${product.reviews.length}k Reviews',
                                    style: getRegularStyle(
                                        color: greyFontColor,
                                        fontSize: FontSize.s16),
                                  )
                                ],
                              ),
                              const SizedBox(width: 10),
                              Column(
                                children: const [
                                  RatingItem(
                                    index: '5',
                                    figure: '1.5k',
                                    progressValue: 0.8,
                                  ),
                                  RatingItem(
                                    index: '4',
                                    figure: '710',
                                    progressValue: 0.4,
                                  ),
                                  RatingItem(
                                    index: '3',
                                    figure: '140',
                                    progressValue: 0.3,
                                  ),
                                  RatingItem(
                                    index: '2',
                                    figure: '100',
                                    progressValue: 0.2,
                                  ),
                                  RatingItem(
                                    index: '1',
                                    figure: '120',
                                    progressValue: 0.1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Review with images & videos',
                            style: getMediumStyle(
                              color: accentColor,
                              fontSize: FontSize.s16,
                            ),
                          ),
                          SizedBox(
                            height: 90,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              itemCount: product.otherImgs.length,
                              itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(3, 8.0, 8.0, 8.0),
                                child: Container(
                                  height: 20,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: otherImgsBg,
                                  ),
                                  child: Image.asset(
                                    product.otherImgs[index],
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Divider(
                            color: storeColor,
                            thickness: 0.4,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Top Reviews:',
                            style: getMediumStyle(
                              color: accentColor,
                              fontSize: FontSize.s16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Showing 3 of ${product.reviews.length}k reviews',
                                style: getRegularStyle(
                                  color: greyFontColor,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: boxBg,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: DropdownButton(
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: greyFontColor,
                                  ),
                                  underline: Container(),
                                  value: currentReviewTag,
                                  items: reviewTags
                                      .map(
                                        (value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: getRegularStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      currentReviewTag = value!;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height / 1.6,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(top: 15),
                              itemCount: product.reviews.length,
                              itemBuilder: (context, index) {
                                var item =
                                    reviewData.findById(product.reviews[index]);

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: boxBg,
                                              backgroundImage:
                                                  AssetImage(item.imgUrl),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              item.username,
                                              style: getMediumStyle(
                                                color: Colors.black,
                                                fontSize: FontSize.s14,
                                              ),
                                            )
                                          ],
                                        ),

                                        //
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Image.asset(
                                                  AssetManager.fullStar,
                                                  width: 20,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  item.rating.toString(),
                                                  style: getBoldStyle(
                                                    color: Colors.black,
                                                    fontSize: FontSize.s16,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: () => {},
                                                  child: const Icon(
                                                    Icons.more_horiz,
                                                    color: greyFontColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    //
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        reviewChip(text: 'Positive condition'),
                                        reviewChip(text: 'Nice and soft'),
                                        reviewChip(text: 'Smooth and new'),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      item.review,
                                      style: getRegularStyle(
                                        color: Colors.black,
                                        fontSize: FontSize.s14,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () => {},
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.thumb_up,
                                                color: primaryColor,
                                                size: 18,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                'Helpful ?',
                                                style: getMediumStyle(
                                                    color: primaryColor,
                                                    fontSize: FontSize.s14),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'Yesterday',
                                          style: getRegularStyle(
                                            color: greyFontColor,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    const Divider(
                                      color: storeColor,
                                      thickness: 0.4,
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                );
                              },
                            ),
                          )
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
