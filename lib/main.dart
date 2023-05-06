import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        statusBarBrightness: Brightness.dark
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getLightTheme(),
      title: 'Shoe\'s Store',
      home: const EntryScreen(),
      routes: routes,
    );
  }
}
