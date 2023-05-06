import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shoe_stores/resources/styles_manager.dart';
import 'package:shoe_stores/views/widgets/cart_icon.dart';
import 'package:shoe_stores/views/widgets/message_icon.dart';
import 'package:shoe_stores/views/widgets/search_box.dart';
import 'package:shoe_stores/views/widgets/welcome_intro.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
          MessageIcon(),
          SizedBox(width: 18),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: carouselItems.length,
            itemBuilder: (context, index, i) => Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(carouselItems[index].imgSrc),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    right: 18.0,
                    left: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          carouselItems[index].hashTag,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        DotsIndicator(
                          dotsCount: carouselItems.length,
                          position: currentCarouselIndex,
                          decorator: DotsDecorator(
                            color: Colors.grey,
                            size: const Size.square(4.0),
                            activeSize: const Size(18.0, 5.0),
                            activeColor: accentColor,
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            spacing: const EdgeInsets.only(right: 4),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      carouselItems[index].title,
                      style: getBoldStyle(
                        color: Colors.black,
                        fontSize: FontSize.s40,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(carouselItems[index].desc,
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: AppSize.s10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                      ),
                      onPressed: () => checkItOut(),
                      child: const Text('Check this out'),
                    )
                  ],
                ),
              ),
            ),
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
