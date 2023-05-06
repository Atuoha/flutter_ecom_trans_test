import 'package:flutter/foundation.dart';
import 'package:shoe_stores/models/review.dart';
import 'package:shoe_stores/models/shipping_information.dart';

class Product with ChangeNotifier {
  final String id;
  final String storeId;
  final String name;
  final String brandName;
  final String colorName;
  final String catId;
  final String imageUrl;
  final List<String> otherImgs;
  final String description;
  final List<String> descriptionList;
  final double price;
  final double rating;
  final List<int> reviews;
  final double soldNumber;
  final ShippingInformation shippingInformation;
  bool isFavorite;

  Product({
    required this.id,
    required this.storeId,
    required this.name,
    required this.brandName,
    required this.catId,
    required this.imageUrl,
    required this.otherImgs,
    required this.description,
    required this.descriptionList,
    required this.reviews,
    required this.soldNumber,
    required this.shippingInformation,
    required this.colorName,
    required this.price,
    required this.rating,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}
