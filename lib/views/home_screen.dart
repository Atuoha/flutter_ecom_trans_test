import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_stores/resources/styles_manager.dart';
import 'package:shoe_stores/views/widgets/carousel_single_slider.dart';
import 'package:shoe_stores/views/widgets/cart_icon.dart';
import 'package:shoe_stores/views/widgets/k_dotsIndicator.dart';
import 'package:shoe_stores/views/widgets/message_icon.dart';
import 'package:shoe_stores/views/widgets/search_box.dart';
import 'package:shoe_stores/views/widgets/single_icon_section.dart';
import '../../resources/values_manager.dart';
import '../constants/color.dart';
import '../models/carousel_item.dart';
import '../models/icon_section.dart';
import '../models/product.dart';
import '../providers/category.dart';
import '../providers/product.dart';
import '../resources/assets_manager.dart';
import '../resources/font_manager.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final TextEditingController searchText = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        _isScrolled = _scrollController.offset > 0;
      });
    });
  }

  var currentCarouselIndex = 0;
  var currentIconSectionIndex = 0;

  final List<IconSection> iconSections = [
    IconSection(icon: Icons.grid_view, title: 'Category'),
    IconSection(icon: Icons.flight, title: 'Flight'),
    IconSection(icon: Icons.receipt, title: 'Bill'),
    IconSection(icon: Icons.language, title: 'Data plan'),
    IconSection(icon: Icons.monetization_on, title: 'Top Up'),
  ];

  final List<CarouselItem> carouselItems = [
    CarouselItem(
      hashTag: '#FASHION DAY',
      title: '80% OFF',
      desc: 'Discover fashion that suits to \n your style',
      imgSrc: AssetManager.slider1,
    ),
    CarouselItem(
      hashTag: '#NEW COLLECTION',
      title: '75% OFF',
      desc: 'Select designs that suits to \n your style',
      imgSrc: AssetManager.slider3,
    ),
    CarouselItem(
      hashTag: '#FASHION WEEK',
      title: '50% OFF',
      desc: 'Choose the shoes that suits to \n your style',
      imgSrc: AssetManager.slider2,
    ),
  ];

  void checkItOut() {}

  void setCurrentIconSection(int index) {
    setState(() {
      currentIconSectionIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Product> products =
        Provider.of<Products>(context, listen: false).availableProducts;

    var categoryData = Provider.of<Categories>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: _isScrolled ? Colors.white : Colors.transparent,
        title: SearchBox(searchText: searchText),
        actions: const [
          CartIcon(),
          SizedBox(width: 10),
          MessageIcon(),
          SizedBox(width: 18),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: carouselItems.length,
              itemBuilder: (context, index, i) {
                var item = carouselItems[index];
                return carouselSingleSlider(
                  item: item,
                  context: context,
                  carouselLength: carouselItems.length,
                  currentCarouselIndex: currentCarouselIndex,
                  action: checkItOut,
                );
              },
              options: CarouselOptions(
                onPageChanged: (index, reason) => setState(() {
                  currentCarouselIndex = index;
                }),
                height: size.height / 2.5,
                autoPlay: true,
                enlargeCenterPage: false,
                viewportFraction: 1,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: size.height / 8,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: iconSections.length,
                itemBuilder: (context, index) {
                  var item = iconSections[index];
                  return SingleIconSection(
                    item: item,
                    index: index,
                    setCurrentIconSection: setCurrentIconSection,
                    currentIconSectionIndex: currentIconSectionIndex,
                  );
                },
              ),
            ),
            const SizedBox(height: AppSize.s10),
            KDotsIndicator(
              dotsCount: carouselItems.length,
              position: currentCarouselIndex,
            ),
            const SizedBox(height: 20),
            Container(
              height: size.height / 1.32,
              color: gridBg,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Best Sale Product',
                          style: getMediumStyle(
                            color: accentColor,
                            fontSize: FontSize.s16,
                          ),
                        ),
                        Text(
                          'See more',
                          style: getMediumStyle(
                            color: primaryColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: size.height / 1.49,
                      child: GridView.builder(
                        itemCount: products.length,
                        padding: const EdgeInsets.only(top: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 15,
                        ),
                        itemBuilder: (context, index) {
                          Product item = products[index];
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
                                  child: GestureDetector(
                                    onTap: () => null,
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: iconColor,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 25,
                                  left: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
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
                                    style: getMediumStyle(
                                        color: primaryColor,
                                        fontSize: FontSize.s16),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
