import '../views/main_screen.dart';
import '../views/product/details.dart';
import '../views/splash/entry.dart';
import '../views/splash/splash.dart';
import '../views/store/details.dart';

class RouteManager {
  static const String splashScreen = "/splash";
  static const String entryScreen = "/entry_screen";
  static const String mainScreen = '/customer_home_screen';
  static const String productDetails = '/product_details_screen';
  static const String storeScreen = '/store_screen';
}

final routes = {
  RouteManager.splashScreen: (context) => const SplashScreen(),
  RouteManager.entryScreen: (context) => const EntryScreen(),
  RouteManager.mainScreen: (context) => const MainScreen(),
  RouteManager.productDetails: (context) => const ProductDetails(),
  RouteManager.storeScreen: (context)=> const StoreDetails(),
};
