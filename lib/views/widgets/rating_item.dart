import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../resources/assets_manager.dart';
import '../../resources/styles_manager.dart';

class RatingItem extends StatelessWidget {
  const RatingItem({
    Key? key,
    required this.index,
    required this.figure,
    required this.progressValue,
  }) : super(key: key);
  final String index;
  final String figure;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Image.asset(
            AssetManager.fullStar,
            width: 20,
          ),
          const SizedBox(width: 5),
          Text(index),
          const SizedBox(width: 10),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    value: progressValue,
                    minHeight: 10,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(figure, style: getMediumStyle(color: accentColor))
            ],
          ),
        ],
      ),
    );
  }
}
