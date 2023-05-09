import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_stores/resources/styles_manager.dart';
import '../../constants/color.dart';
import '../../constants/enums/status.dart';
import '../../controllers/route_manager.dart';
import '../../providers/cart.dart';
import '../../providers/orders.dart';
import '../../resources/font_manager.dart';
import '../widgets/cart_icon.dart';
import '../widgets/single_cart_item.dart';
import '../widgets/snack_msg.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<Cart>(context);

    void orderNow() {
      if (cartData.totalAmount > 0) {
        Provider.of<Orders>(context, listen: false)
            .addOrder(cartData.totalAmount, cartData.items.values.toList());
        Provider.of<Cart>(context, listen: false).clearCart();
        Navigator.of(context).pushNamed(RouteManager.orderScreen);
      } else {
        displaySnackBar(
          status: Status.error,
          message: 'Cart is empty!',
          context: context,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.chevron_left,
                color: iconColor,
              ),
            );
          },
        ),
        title: const Text('Cart'),
        actions: const [
          CartIcon(),
          SizedBox(width: 18),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: cartData.items.isEmpty
            ? const Center(
                child: Text(
                  'Opps! Your cart list is empty',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: cartData.items.length,
                itemBuilder: (context, index) {
                  var item = cartData.items.values.toList()[index];
                  return SingleCartItem(item: item, cartData: cartData);
                },
              ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: getRegularStyle(
                      color: greyFontColor,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '\$${cartData.totalAmount.toStringAsFixed(2)}',
                    style: getMediumStyle(
                      color: primaryColor,
                      fontSize: FontSize.s25,
                    ),
                  )
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(Icons.shopping_bag_outlined,
                              color: Colors.white),
                          const SizedBox(width: 15),
                          Text(
                            cartData.itemCount.toString(),
                            style: getRegularStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => orderNow(),
                    child: Container(
                      height: 50,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Order Now',
                          style: getMediumStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
