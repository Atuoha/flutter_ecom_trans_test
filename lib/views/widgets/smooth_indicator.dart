import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants/color.dart';

class CustomSmoothIndicator extends StatelessWidget {
  const CustomSmoothIndicator({
    Key? key,
    required PageController pageController,
    required this.itemCount,
    required this.color,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;
  final int itemCount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _pageController,
      count: itemCount,
      effect: CustomizableEffect(
        activeDotDecoration: DotDecoration(
          width: 25,
          height: 3,
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        dotDecoration: DotDecoration(
          width: 25,
          height: 3,
          color: greyShade,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
