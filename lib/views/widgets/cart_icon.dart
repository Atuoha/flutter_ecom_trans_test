import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../constants/color.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      position: const BadgePosition(start: 20, bottom: 30),
      badgeColor: notifBg,
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(5),
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 2),
      badgeContent: const Text(
        '1',
        style: TextStyle(color: Colors.white),
      ),
      showBadge: true,
      child: const Icon(
        Icons.shopping_bag_outlined,
        color: iconColor,
      ),
    );
  }
}
