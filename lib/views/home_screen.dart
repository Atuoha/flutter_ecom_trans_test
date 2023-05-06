import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shoe_stores/resources/styles_manager.dart';
import 'package:shoe_stores/views/widgets/carousel_single_slider.dart';
import 'package:shoe_stores/views/widgets/cart_icon.dart';
import 'package:shoe_stores/views/widgets/message_icon.dart';
import 'package:shoe_stores/views/widgets/search_box.dart';
import '../../resources/values_manager.dart';
import '../constants/color.dart';
import '../models/carousel_item.dart';
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
        ],
      ),
    );
  }
}
