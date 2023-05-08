import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shoe_stores/models/shipping_information.dart';

import '../models/product.dart';

class Products with ChangeNotifier {
  void toggleIsFavorite(String id) async {
    Product product =
        _availableProducts.firstWhere((product) => product.id == id);
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
      imageUrl: 'assets/images/shoe_imgs/1_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 30.90,
      storeId: '1',
      reviews: [1, 2, 3],
      otherImgs: [
        'assets/images/shoe_imgs/1_1.png',
        'assets/images/shoe_imgs/1_2.png',
        'assets/images/shoe_imgs/1_3.png',
        'assets/images/shoe_imgs/1_4.png',
        'assets/images/shoe_imgs/1_5.png',
        'assets/images/shoe_imgs/1_6.png',
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
      imageUrl: 'assets/images/shoe_imgs/2_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 20.90,
      storeId: '2',
      reviews: [1, 2, 3],
      otherImgs: [
        'assets/images/shoe_imgs/2_1.png',
        'assets/images/shoe_imgs/2_2.png',
        'assets/images/shoe_imgs/2_3.png',
        'assets/images/shoe_imgs/2_4.png',
        'assets/images/shoe_imgs/2_5.png',
        'assets/images/shoe_imgs/2_6.png',
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
      isFavorite: true,
    ),
    Product(
      id: 'p3',
      name: 'Sleek Nike',
      imageUrl: 'assets/images/shoe_imgs/3_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 60.90,
      storeId: '3',
      reviews: [1, 2, 3],
      otherImgs: [
        'assets/images/shoe_imgs/3_1.png',
        'assets/images/shoe_imgs/3_2.png',
        'assets/images/shoe_imgs/3_3.png',
        'assets/images/shoe_imgs/3_4.png',
        'assets/images/shoe_imgs/3_5.png',
        'assets/images/shoe_imgs/3_6.png',
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
      name: 'Nike BackPack',
      imageUrl: 'assets/images/shoe_imgs/4_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 90.90,
      storeId: '1',
      reviews: [1, 2, 3],
      otherImgs: [
        'assets/images/shoe_imgs/4_1.png',
        'assets/images/shoe_imgs/4_2.png',
        'assets/images/shoe_imgs/4_3.png',
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
      imageUrl: 'assets/images/shoe_imgs/5_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 50.90,
      storeId: '2',
      reviews: [1, 2, 3],
      otherImgs: [
        'assets/images/shoe_imgs/5_1.png',
        'assets/images/shoe_imgs/5_2.png',
        'assets/images/shoe_imgs/5_3.png',
        'assets/images/shoe_imgs/5_4.png',
        'assets/images/shoe_imgs/5_5.png',
        'assets/images/shoe_imgs/5_6.png',
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
      imageUrl: 'assets/images/shoe_imgs/6_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 70.90,
      storeId: '2',
      reviews: [1, 2, 3],
      otherImgs: [
        'assets/images/shoe_imgs/6_1.png',
        'assets/images/shoe_imgs/6_2.png',
        'assets/images/shoe_imgs/6_3.png',
        'assets/images/shoe_imgs/6_4.png',
        'assets/images/shoe_imgs/6_5.png',
        'assets/images/shoe_imgs/6_6.png',
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
    Product(
      id: 'p7',
      name: 'Neo Nike',
      imageUrl: 'assets/images/shoe_imgs/7_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 20.90,
      storeId: '3',
      reviews: [1, 2, 3],
      otherImgs: [
        'assets/images/shoe_imgs/7_1.png',
        'assets/images/shoe_imgs/8_3.png',
        'assets/images/shoe_imgs/7_3.png',
        'assets/images/shoe_imgs/7_4.png',
        'assets/images/shoe_imgs/8_1.png',
        'assets/images/shoe_imgs/8_8.png',
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
      id: 'p8',
      name: 'Leather BackPack',
      imageUrl: 'assets/images/shoe_imgs/11_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 40.90,
      storeId: '2',
      reviews: [1, 2, 3],
      otherImgs: [
        'assets/images/shoe_imgs/11_1.png',
        'assets/images/shoe_imgs/11_2.png',
        'assets/images/shoe_imgs/11_3.png',
        'assets/images/shoe_imgs/11_8.png',
        'assets/images/shoe_imgs/11_5.png',
        'assets/images/shoe_imgs/11_6.png',
      ],
      colorName: 'Black',
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
      id: 'p9',
      name: 'Ultra Nike',
      imageUrl: 'assets/images/shoe_imgs/12_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 50.90,
      storeId: '2',
      reviews: [1, 2, 3],
      otherImgs: [
        'assets/images/shoe_imgs/12_1.png',
        'assets/images/shoe_imgs/12_2.png',
        'assets/images/shoe_imgs/12_3.png',
        'assets/images/shoe_imgs/12_5.png',
        'assets/images/shoe_imgs/12_6.png',
      ],
      colorName: 'Blue shade',
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
      id: 'p10',
      name: 'Nike Sleeve',
      imageUrl: 'assets/images/shoe_imgs/13_1.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit ut quam convallis sollicitudin. Aliquam pretium velit euismod purus faucibus, in elementum libero pharetra. Curabitur auctor semper felis a suscipit.',
      descriptionList: [
        'Lorem ipsum dolor sit amet',
        'Curabitur auctor semper felis a suscipit',
        'Sed luctus quam vitae mauris imperdiet',
        'Proin quis ipsum eget turpis varius egestas',
        'Fusce tristique aliquam quam, ut convallis diam',
      ],
      price: 70.90,
      storeId: '3',
      reviews: [1, 2, 3],
      otherImgs: [
        'assets/images/shoe_imgs/13_1.png',
        'assets/images/shoe_imgs/13_2.png',
        'assets/images/shoe_imgs/13_3.png',
        'assets/images/shoe_imgs/13_4.png',
      ],
      colorName: 'Black',
      brandName: 'Grey nike',
      catId: '3',
      soldNumber: 15,
      shippingInformation: ShippingInformation(
        delivery: 'Shipping from Lorem ipsum dolor',
        shipping: 'FREE International Shipping',
        arrival: 'Estimated arrival on 25-27 Oct 2023',
      ),
      rating: 4.0,
    ),
  ];
}
