import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shoe_stores/models/shipping_information.dart';

import '../models/product.dart';

class Products with ChangeNotifier {
  void toggleisFavorite(Product product) async {
    product.toggleFavorite();
    notifyListeners();
  }

  bool isItemOnFavorite(Product product) {
    return _availableProducts.any((product) => product.isFavorite == true);
  }

  List<Product> get availableProducts {
    return [..._availableProducts];
  }

  Product findById(String id) {
    return availableProducts.firstWhere((product) => product.id == id);
  }

  List<Product> get favItems {
    return _availableProducts.where((product) => product.isFavorite).toList();
  }

  final List<Product> _availableProducts = [
    Product(
      id: 'p1',
      name: 'Nike Ups',
      imageUrl: 'images/shoe_imgs/1_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 30.9,
      storeId: '1',
      reviews: [1, 2, 3],
      otherImgs: [
        'images/shoe_imgs/1_2.png',
        'images/shoe_imgs/1_3.png',
        'images/shoe_imgs/1_4.png',
        'images/shoe_imgs/1_5.png',
        'images/shoe_imgs/1_6.png',
      ],
      colorName: 'Green',
      brandName: 'Leo nike',
      catId: '1',
      soldNumber: 20,
      shippingInformation: ShippingInformation(
        delivery: 'Shipping from Lorem ipsum dolor',
        shipping: 'FREE International Shipping',
        arrival: 'Estimated arrival on 25-27 Oct 2023',
      ),
      rating: 4.3,
    ),
    Product(
      id: 'p2',
      name: 'Nike Top',
      imageUrl: 'images/shoe_imgs/2_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 20.9,
      storeId: '2',
      reviews: [1, 2, 3],
      otherImgs: [
        'images/shoe_imgs/2_2.png',
        'images/shoe_imgs/2_3.png',
        'images/shoe_imgs/2_4.png',
        'images/shoe_imgs/2_5.png',
        'images/shoe_imgs/2_6.png',
      ],
      colorName: 'Red',
      brandName: 'Cat nike',
      catId: '3',
      soldNumber: 50,
      shippingInformation: ShippingInformation(
        delivery: 'Shipping from Lorem ipsum dolor',
        shipping: 'FREE International Shipping',
        arrival: 'Estimated arrival on 25-27 Oct 2023',
      ),
      rating: 4.5,
    ),
    Product(
      id: 'p3',
      name: 'Sleek Nike',
      imageUrl: 'images/shoe_imgs/3_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 60.9,
      storeId: '3',
      reviews: [1, 2, 3],
      otherImgs: [
        'images/shoe_imgs/3_2.png',
        'images/shoe_imgs/3_3.png',
        'images/shoe_imgs/3_4.png',
        'images/shoe_imgs/3_5.png',
        'images/shoe_imgs/3_6.png',
      ],
      colorName: 'White',
      brandName: 'Leo nike',
      catId: '3',
      soldNumber: 50,
      shippingInformation: ShippingInformation(
        delivery: 'Shipping from Lorem ipsum dolor',
        shipping: 'FREE International Shipping',
        arrival: 'Estimated arrival on 25-27 Oct 2023',
      ),
      rating: 5.0,
    ),
    Product(
      id: 'p4',
      name: 'Leather BackPack',
      imageUrl: 'images/shoe_imgs/4_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 90.9,
      storeId: '1',
      reviews: [1, 2, 3],
      otherImgs: [
        'images/shoe_imgs/4_2.png',
        'images/shoe_imgs/4_3.png',
      ],
      colorName: 'Blue',
      brandName: 'Leo nike',
      catId: '4',
      soldNumber: 120,
      shippingInformation: ShippingInformation(
        delivery: 'Shipping from Lorem ipsum dolor',
        shipping: 'FREE International Shipping',
        arrival: 'Estimated arrival on 25-27 Oct 2023',
      ),
      rating: 3.3,
    ),
    Product(
      id: 'p5',
      name: 'Smooth Nike',
      imageUrl: 'images/shoe_imgs/5_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 50.9,
      storeId: '2',
      reviews: [1, 2, 3],
      otherImgs: [
        'images/shoe_imgs/5_2.png',
        'images/shoe_imgs/5_3.png',
        'images/shoe_imgs/5_4.png',
        'images/shoe_imgs/5_5.png',
        'images/shoe_imgs/5_6.png',
      ],
      colorName: 'White',
      brandName: 'Smart nike',
      catId: '4',
      soldNumber: 120,
      shippingInformation: ShippingInformation(
        delivery: 'Shipping from Lorem ipsum dolor',
        shipping: 'FREE International Shipping',
        arrival: 'Estimated arrival on 25-27 Oct 2023',
      ),
      rating: 2.3,
    ),
    Product(
      id: 'p6',
      name: 'Nike Slider',
      imageUrl: 'images/shoe_imgs/6_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 70.9,
      storeId: '2',
      reviews: [1, 2, 3],
      otherImgs: [
        'images/shoe_imgs/6_2.png',
        'images/shoe_imgs/6_3.png',
        'images/shoe_imgs/6_4.png',
        'images/shoe_imgs/6_5.png',
        'images/shoe_imgs/6_6.png',
      ],
      colorName: 'Green',
      brandName: 'Leo nike',
      catId: '1',
      soldNumber: 10,
      shippingInformation: ShippingInformation(
        delivery: 'Shipping from Lorem ipsum dolor',
        shipping: 'FREE International Shipping',
        arrival: 'Estimated arrival on 25-27 Oct 2023',
      ),
      rating: 1.0,
    ),
  ];
}
