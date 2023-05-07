import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
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
import '../resources/assets_manager.dart';
import '../resources/font_manager.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final TextEditingController searchText = TextEditingController();

  var currentCarouselIndex = 0;

  var currentIconSectionIndex = 0;

  final List<IconSection> iconSections = [
    IconSection(icon: Icons.grid_view, title: 'Category'),
    IconSection(icon: Icons.flight, title: 'Flight'),
    IconSection(icon: Icons.receipt, title: 'Bill'),
    IconSection(icon: Icons.language, title: 'Data'),
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

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SearchBox(searchText: searchText),
        actions: const [
          CartIcon(),
          SizedBox(width: 10),
          MessageIcon(),
          SizedBox(width: 18),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
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
          )
        ],
      ),
    );
  }
}
