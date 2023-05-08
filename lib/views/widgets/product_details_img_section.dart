import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../../constants/color.dart';
import '../../models/product.dart';

Container productDetailsImageSection(
  Size size,
  Product product,
  currentImageIndex,
  setImageIndex,
) {
  return Container(
    height: size.height / 2,
    decoration: BoxDecoration(
      color: boxBg,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PinchZoom(
            resetDuration: const Duration(milliseconds: 100),
            maxScale: 2.5,
            child: Hero(
              tag:product.id,
              child: Image.asset(
                product.otherImgs[currentImageIndex],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: SizedBox(
            height: size.height / 2.2,
            width: size.width / 3.8,
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: product.otherImgs.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: () => setImageIndex(index),
                  child: Container(
                    height: 70,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: otherImgsBg,
                      boxShadow: [
                        currentImageIndex == index
                            ? const BoxShadow(
                                color: accentColor,
                                blurRadius: 3,
                                spreadRadius: 7,
                                blurStyle: BlurStyle.outer,
                                offset: Offset(0, 3),
                              )
                            : const BoxShadow(),
                      ],
                    ),
                    child: Image.asset(
                      product.otherImgs[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
