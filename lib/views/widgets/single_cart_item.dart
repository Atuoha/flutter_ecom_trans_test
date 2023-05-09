import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../constants/enums/yes_no.dart';
import '../../controllers/route_manager.dart';
import '../../models/cart_item.dart';
import '../../providers/cart.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class SingleCartItem extends StatelessWidget {
  const SingleCartItem({
    Key? key,
    required this.item,
    required this.cartData,
  }) : super(key: key);

  final CartItem item;
  final Cart cartData;

  @override
  Widget build(BuildContext context) {
    Widget textAction(String text, YesNo operation) {
      return ElevatedButton(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          switch (operation) {
            case YesNo.no:
              Navigator.of(context).pop(false);
              break;
            case YesNo.yes:
              Navigator.of(context).pop(true);
              break;
            default:
          }
        },
      );
    }

    return Dismissible(
      key: ValueKey(item.id),
      confirmDismiss: (direction) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          elevation: 3,
          title: Text(
            'Are you sure?',
            style: getMediumStyle(
              color: Colors.black,
              fontSize: FontSize.s18,
            ),
          ),
          content: Text(
            'Do you want to remove ${item.name} from cart?',
            style: getRegularStyle(
              color: Colors.black,
              fontSize: FontSize.s14,
            ),
          ),
          actions: [
            textAction('Yes', YesNo.yes),
            textAction('No', YesNo.no),
          ],
        ),
      ),
      onDismissed: (direction) => cartData.removeFromCart(item.productId),
      direction: DismissDirection.endToStart,
      background: Container(
        height: 115,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          RouteManager.productDetails,
          arguments: {'product_id': item.productId},
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(item.imageUrl),
              ),
              title: Text(item.name),
              subtitle: Row(
                children: [
                  Text(
                    '\$${item.price}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getMediumStyle(color: accentColor),
                  ),
                  const SizedBox(width: 5),
                  Text('Quantity: ${item.quantity}')
                ],
              ),
              trailing: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => {
                      item.quantity > 1
                          ? cartData.toggleQuantity(
                              item.productId,
                              'decrement',
                            )
                          : null
                    },
                    child: Text(
                      '-',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: item.quantity == 1 ? Colors.grey : primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () => {
                      cartData.toggleQuantity(
                        item.productId,
                        'increment',
                      )
                    },
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
