
import '../views/main_screen.dart';
import '../views/splash/entry.dart';
import '../views/splash/splash.dart';

class RouteManager {
  static const String splashScreen = "/splash";
  static const String entryScreen = "/entry_screen";
  static const String mainScreen = '/customerHomeScreen';




}

final routes = {
  RouteManager.splashScreen: (context) => const SplashScreen(),
  RouteManager.entryScreen: (context) => const EntryScreen(),
  RouteManager.mainScreen: (context)=> const MainScreen(),

};
