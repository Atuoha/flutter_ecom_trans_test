import 'package:flutter/material.dart';
import '../../constants/color.dart';
import '../../models/carousel_item.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import 'k_dotsIndicator.dart';

Container carouselSingleSlider({
  required CarouselItem item,
  required BuildContext context,
  required int carouselLength,
  required int currentCarouselIndex,
  required Function action,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(item.imgSrc),
        fit: BoxFit.cover,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        right: 18.0,
        left: 18.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.hashTag,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              KDotsIndicator(
                dotsCount: carouselLength,
                position: currentCarouselIndex,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            item.title,
            style: getBoldStyle(
              color: Colors.black,
              fontSize: FontSize.s40,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            item.desc,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: AppSize.s10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
            ),
            onPressed: () => action(),
            child: const Text('Check this out'),
          )
        ],
      ),
    ),
  );
}
