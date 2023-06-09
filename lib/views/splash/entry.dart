import 'dart:async';
import 'package:flutter/material.dart';
import '../../resources/assets_manager.dart';
import '../../controllers/route_manager.dart';
import '../../constants/color.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  void initState() {
    // var model = Navigator.of(context);
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    //
    // bool firstRun = preferences.getBool('isFirstRun') ?? true;
    //
    // if (firstRun) {
    //   model.push(MaterialPageRoute(builder: (context) => const SplashScreen()));
    //   preferences.setBool('isFirstRun', false);
    // }

    Timer(const Duration(seconds: 3), () {
       Navigator.of(context).pushNamed(RouteManager.splashScreen);
     });


    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset(AssetManager.logoTransparent),
      ),
    );
  }
}
