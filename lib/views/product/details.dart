import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';

import '../../constants/color.dart';
import '../../models/product.dart';
import '../../providers/product.dart';
import '../widgets/cart_icon.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> {
  var currentImageIndex = 0;

  void setImageIndex(int index) {
    setState(() {
      currentImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String id = data['product_id'];
    var productData = Provider.of<Products>(context);

    Product product = productData.findById(id);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.chevron_left, color: iconColor),
            );
          },
        ),
        actions: [
          GestureDetector(
            onTap: () => productData.toggleIsFavorite(product.id),
            child: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: product.isFavorite ? notifBg : iconColor,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.share_outlined, color: iconColor),
          const CartIcon(),
          const SizedBox(width: 18),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: size.height / 2,
          decoration: BoxDecoration(
            color: boxBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:

                PinchZoom(
                  child: Image.asset(
                    product.otherImgs[currentImageIndex],
                  ),
                  resetDuration: const Duration(milliseconds: 100),
                  maxScale: 2.5,
                ),


              ),
              Positioned(
                top: 10,
                left: 10,
                child: SizedBox(
                  height: size.height / 2.2,
                  width: size.width / 3.8,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: product.otherImgs.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: GestureDetector(
                        onTap: () => setImageIndex(index),
                        child: Container(
                          height: 70,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: otherImgsBg,
                            boxShadow: [
                              currentImageIndex == index
                                  ? const BoxShadow(
                                      color: accentColor,
                                      blurRadius: 3,
                                      spreadRadius: 7,
                                      blurStyle: BlurStyle.outer,
                                      offset: Offset(0, 3),
                                    )
                                  : const BoxShadow(),
                            ],
                          ),
                          child: Image.asset(
                            product.otherImgs[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
