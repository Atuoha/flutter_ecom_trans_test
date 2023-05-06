import 'package:flutter/material.dart';
import 'package:shoe_stores/views/settings/settings.dart';
import 'package:shoe_stores/views/voucher/voucher.dart';
import 'package:shoe_stores/views/wallet/wallet.dart';
import '../../constants/color.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _pageIndex = 0;
  final List<Widget> _pages = const [
    CustomerHomeScreen(),
    VoucherScreen(),
    WalletScreen(),
    SettingsScreen(),
  ];

  void setNewPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number)),
          BottomNavigationBarItem(icon: Icon(Icons.wallet)),
          BottomNavigationBarItem(icon: Icon(Icons.settings)),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
