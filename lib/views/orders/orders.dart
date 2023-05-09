import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_stores/views/widgets/snack_msg.dart';
import '../../constants/color.dart';
import '../../constants/enums/status.dart';
import '../../providers/orders.dart';
import '../widgets/order_down_summary.dart';
import '../widgets/single_order_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  void orderNow() {
    // Todo: Implement Order
    displaySnackBar(
      status: Status.success,
      message: 'Opps! This is a demo :)',
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Orders',
        ),
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.chevron_left, color: iconColor),
            );
          },
        ),
      ),
      body: orderData.orders.isEmpty
          ? const Center(
              child: Text(
                'Opps! Your order list is empty',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            )
          : Consumer<Orders>(
              builder: (_, orders, o) => Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: ListView.builder(
                      itemCount: orders.orders.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleOrderItem(
                          id: orders.orders[index].id,
                          totalAmount: orders.orders[index].totalAmount,
                          date: orders.orders[index].orderDate,
                          orders: orders.orders[index],
                        ),
                      ),
                    ),
                  ),
                  OrderDownSummary(
                    totalAmount: orders.getTotal,
                    cartItems: orders.orders,
                    orderNow: orderNow,
                  )
                ],
              ),
            ),
    );
  }
}
