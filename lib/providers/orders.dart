import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/order_item.dart';
import 'cart.dart';



class Orders extends ChangeNotifier {
   List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

 void addOrder(double totalAmount, List<CartItem> products)  {
    var newOrder = OrderItem(
      id: DateTime.now().toString(),
      products: products,
      totalAmount: totalAmount,
      orderDate: DateTime.now(),
    );
    _orders.insert(0, newOrder);
    notifyListeners();
  }

  double get getTotal {
    var total = 0.0;
    for (var order in _orders) {
      total += order.totalAmount;
    }
    return total;
  }

  void removeOrder(id) {
    _orders.removeWhere((order) => order.id == id);
    notifyListeners();
  }

  void clearOrder() {
    _orders.clear();
    notifyListeners();
  }
}
