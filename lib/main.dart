import 'package:ecommerce/shop/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/auth/signup_page.dart';
import 'package:ecommerce/auth/login_page.dart';
import 'package:ecommerce/shop/items_page.dart';

import 'shop/product_page.dart';

void main() {
  runApp(Ecommerce());
}

class Ecommerce extends StatelessWidget {
  const Ecommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
      routes: {
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        ProductPage.routeName: (context) => const ProductPage(),
        ShoppingCartPage.routeName: (context) => ShoppingCartPage()
      },
      // home: Scaffold(
      //   appBar: AppBar(
      //       backgroundColor: Colors.amber, title: const Text('E-commerce')),
      //   body: const Center(
      //     child: Padding(
      //       child: Text('Welcome to  shop it!'),
      //       padding: EdgeInsets.all(10),
      //     ),
      //   ),
      // ),
    );
  }
}
