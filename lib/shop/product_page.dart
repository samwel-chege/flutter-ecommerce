import 'dart:convert';

import 'package:ecommerce/shop/items_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../common.dart';
import 'cart_page.dart';
import '../API/api.dart';
import '../services/functions.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});
  static const routeName = '/products';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    gettoken();

    super.initState();
  }

  Future gettoken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    fetchproducts(jsonDecode(token!));
  }

  var products = [];
  Future fetchproducts(bearerToken) async {
    ProgressDialog pr = ProgressDialog(context, isDismissible: false);
    pr.style(message: 'Fetching data...');
    try {
      pr.show();
      String productsUrl = Api.apiUrl + Api.endpointProducts;

      var responsedata = await httppost(bearerToken, productsUrl, context);

      products = jsonDecode(responsedata);

      Future.delayed(
        Duration(seconds: 2),
        () {
          pr.hide();
        },
      );
    } catch (e) {}
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    productImage: products[index]["img_url"],
                    productName: products[index]["prod_name"],
                    productPrice:
                        double.parse(products[index]["selling_price"]),
                    icon: Icons.shopping_cart,
                    widget: null,
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
