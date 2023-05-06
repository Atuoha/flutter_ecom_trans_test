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
  var _currentPageIndex = 0;
  final List<Widget> _pages = const [
    CustomerHomeScreen(),
    VoucherScreen(),
    WalletScreen(),
    SettingsScreen(),
  ];

  void setNewPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: setNewPage,
        currentIndex: _currentPageIndex,
        selectedIconTheme: const IconThemeData(color: primaryColor),
        unselectedIconTheme: IconThemeData(color: greyShade),
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        selectedItemColor: Colors.black,
        unselectedLabelStyle: const TextStyle(
          color: Colors.black,
          // fontWeight: FontWeight.w300,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'Voucher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: _pages[_currentPageIndex],
    );
  }
}
