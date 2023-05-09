import 'package:flutter/material.dart';
import '../../constants/color.dart';
import '../../models/order_item.dart';

class OrderDownSummary extends StatelessWidget {
  const OrderDownSummary({
    super.key,
    required this.totalAmount,
    required this.cartItems,
    required this.orderNow,
  });

  final double totalAmount;
  final List<OrderItem> cartItems;
  final Function orderNow;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  Text(
                    '\$${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
              onPressed: () => orderNow(),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: const [
                  Text('Buy Now'),
                  SizedBox(width: 10),
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
