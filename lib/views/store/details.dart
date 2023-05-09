import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_stores/resources/styles_manager.dart';
import '../../constants/color.dart';
import '../../controllers/route_manager.dart';
import '../../models/product.dart';
import '../../models/store.dart';
import '../../providers/cart.dart';
import '../../providers/category.dart';
import '../../providers/product.dart';
import '../../providers/stores.dart';
import '../../resources/font_manager.dart';
import '../widgets/cart_icon.dart';
import '../widgets/k_wrap.dart';
import '../widgets/product_details_bottom_sheet.dart';
import '../widgets/product_details_img_section.dart';
import 'package:readmore/readmore.dart';

class StoreDetails extends StatefulWidget {
  const StoreDetails({super.key});

  @override
  State<StoreDetails> createState() => StoreDetailsState();
}

class StoreDetailsState extends State<StoreDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String id = data['store_id'];
    var storeData = Provider.of<Stores>(context);
    var productData = Provider.of<Products>(context);
    Store store = storeData.findById(id);

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
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height / 2.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: boxBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: store.id,
                    child: Image.asset(
                      store.imgUrl,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(Icons.storefront, color: primaryColor),
                  const SizedBox(width: 10),
                  Text(
                    store.name,
                    style: getRegularStyle(
                      color: storeColor,
                      fontSize: FontSize.s18,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Products:',
                style: getMediumStyle(
                  color: accentColor,
                  fontSize: FontSize.s16,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: size.height / 3,
                child: ListView.builder(
                  itemCount: productData.storeProducts(store.id).length,
                  itemBuilder: (context, index) {
                    var item = productData.storeProducts(store.id)[index];
                    return productData.storeProducts(store.id).isNotEmpty
                        ? Card(
                          child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(item.imageUrl),
                              ),
                              title: Text(item.name),
                              subtitle: Text(
                                item.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.chevron_right),
                                onPressed: () => Navigator.of(context).pushNamed(
                                  RouteManager.productDetails,
                                  arguments: {'product_id': item.id},
                                ),
                              ),
                            ),
                        )
                        : const Center(
                            child: Text('Store products are empty'),
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
