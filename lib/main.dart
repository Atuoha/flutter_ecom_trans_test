import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shoe_stores/providers/cart.dart';
import 'package:shoe_stores/providers/category.dart';
import 'package:shoe_stores/providers/orders.dart';
import 'package:shoe_stores/providers/product.dart';
import 'package:shoe_stores/providers/reviews.dart';
import 'package:shoe_stores/providers/stores.dart';
import 'package:shoe_stores/resources/theme_manager.dart';
import 'package:shoe_stores/views/splash/entry.dart';
import 'constants/color.dart';
import 'controllers/route_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: accentColor,
          statusBarBrightness: Brightness.dark),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Reviews()),
        ChangeNotifierProvider(create: (context) => Stores()),
        ChangeNotifierProvider(create: (context) => Categories()),
        ChangeNotifierProvider(create: (context) => Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getLightTheme(),
        title: 'Shoe\'s Store',
        home: const EntryScreen(),
        routes: routes,
      ),
    );
  }
}
