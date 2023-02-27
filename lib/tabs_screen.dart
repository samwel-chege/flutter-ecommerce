import 'package:ecommerce/screens/profile_page.dart';
import 'package:ecommerce/shop/cart_page.dart';
import 'package:ecommerce/shop/product_page.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  static const routeName = '/tabsscreen';
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    // First page
    ProductPage(),
    // Second page
    ShoppingCartPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.blueGrey,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
