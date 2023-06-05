import 'package:ecommerce/shop/CartController.dart';
import 'package:ecommerce/shop/cart_page.dart';
import 'package:ecommerce/shop/product_detail.dart';
import 'package:ecommerce/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/auth/signup_page.dart';
import 'package:ecommerce/auth/login_page.dart';
import 'package:ecommerce/shop/items_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/change_notifier_provider.dart';
import 'shop/product_page.dart';

void main() {
  Get.put(CartController());
  runApp(const GetMaterialApp(
    home: Ecommerce(),
    debugShowCheckedModeBanner: false,
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds and then navigate to the next screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUh0PRwqN8V3L7bW_slt6QYm3MdW8HdNCk0Gz7c6s&s',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Welcome',
              style: TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}

class Ecommerce extends StatelessWidget {
  const Ecommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      // home: SignUpScreen(),
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => SignUpScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        ProductPage.routeName: (context) => ProductPage(),
        ShoppingCartPage.routeName: (context) => ShoppingCartPage(),
        TabsScreen.routeName: (context) => const TabsScreen(),
        // ProductDetail.routeName: (context) => ProductDetail(),
      },
    );
  }
}
