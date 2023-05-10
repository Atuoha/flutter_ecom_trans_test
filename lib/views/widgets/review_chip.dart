import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../resources/styles_manager.dart';

Padding reviewChip({required String text}) {
  return Padding(
    padding: const EdgeInsets.only(right:8.0),
    child: Container(
      height: 25,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: primaryOpacity,
        border: Border.all(
          color: primaryColor,
          width: 1.4,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          text,
          style: getMediumStyle(
            color: primaryColor,
          ),
        ),
      ),
    ),
  );
}
