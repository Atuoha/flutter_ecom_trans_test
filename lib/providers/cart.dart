import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class Cart extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    // ignore: unnecessary_null_comparison
    return _items == null ? 0 : _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void toggleQuantity(String id, String operation) {
    switch (operation) {
      case 'increment':
        if (_items.containsKey(id)) {
          _items.update(
            id,
            (existingCartItem) => CartItem(
              productId: existingCartItem.productId,
              id: existingCartItem.id,
              name: existingCartItem.name,
              price: existingCartItem.price,
              imageUrl: existingCartItem.imageUrl,
              quantity: existingCartItem.quantity + 1,
            ),
          );
        }
        break;
      case 'decrement':
        if (_items.containsKey(id)) {
          _items.update(
            id,
            (existingCartItem) => CartItem(
              productId: existingCartItem.productId,
              id: existingCartItem.id,
              name: existingCartItem.name,
              price: existingCartItem.price,
              imageUrl: existingCartItem.imageUrl,
              quantity: existingCartItem.quantity - 1,
            ),
          );
        }
        break;
      default:
    }
    notifyListeners();
  }

  void removeFromCart(String productID) {
    _items.remove(productID);
    notifyListeners();
  }

  void addItemToCart(
      String productID, String name, double price, String imageUrl) {
    if (_items.containsKey(productID)) {
      // increase quantity

      // Am checking using isItemOnCart to know if a user click on an already added to cart item.
      if (isItemOnCart(productID)) {
        // This operation can only be performed if the user want the item to be removed from the cart so if it is so, the item will be removed from the cart
        _items.remove(productID);
      } else {
        _items.update(
          productID,
          (existingCartItem) => CartItem(
            productId: existingCartItem.productId,
            id: existingCartItem.id,
            name: existingCartItem.name,
            price: existingCartItem.price,
            imageUrl: existingCartItem.imageUrl,
            quantity: existingCartItem.quantity + 1,
          ),
        );
      }
    } else {
      // add product
      _items.putIfAbsent(
        productID,
        () => CartItem(
          productId: productID,
          id: DateTime.now().toString(),
          name: name,
          price: price,
          quantity: 1,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  bool isItemOnCart(String productId) {
    return _items.containsKey(productId);
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
