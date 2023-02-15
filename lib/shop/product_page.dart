import 'package:ecommerce/shop/items_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common.dart';
import 'cart_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});
  static const routeName = '/products';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    gettoken().then((value) {});
    super.initState();
  }

  Future gettoken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ShoppingCartPage.routeName);
            },
            icon: Icon(Icons.shopping_cart))
      ]),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ProductCard(
              productImage:
                  "https://images.unsplash.com/photo-1607522370275-f14206abe5d3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8c2hvZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
              productName: "Shoe",
              productPrice: 20,
              icon: Icons.shopping_cart,
              widget: null,
            );
          },
        ),
      )),
    );
  }
}
