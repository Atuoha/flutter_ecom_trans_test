import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class KWrap extends StatelessWidget {
  const KWrap({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final String data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          '$title:',
          style: getRegularStyle(
            color: greyFontColor,
            fontSize: FontSize.s16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          data,
          style: getMediumStyle(
            color: accentColor,
            fontSize: FontSize.s16,
          ),
        )
      ],
    );
  }
}
