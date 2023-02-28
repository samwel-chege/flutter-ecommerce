import 'dart:convert';

import 'package:ecommerce/auth/login_page.dart';
import 'package:ecommerce/screens/profile_page.dart';
import 'package:ecommerce/shop/items_page.dart';
import 'package:ecommerce/shop/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../common.dart';
import 'cart_page.dart';
import '../API/api.dart';
import '../services/functions.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  // ProductPage({super.key});
  late final ProductPage product;

  static const routeName = '/products';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // final Cart cart = Cart();
  @override
  void initState() {
    gettoken();

    super.initState();
  }

  SnackBar snackBar(message, color) {
    return SnackBar(
        duration: const Duration(seconds: 4),
        backgroundColor: color,
        content: Text(
          message,
          style: const TextStyle(fontSize: 18),
        ));
  }

  Future gettoken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    fetchproducts(jsonDecode(token as String));
  }

  var products = [];
  Future fetchproducts(bearerToken) async {
    ProgressDialog pr = ProgressDialog(context, isDismissible: false);
    pr.style(message: 'Fetching data...');
    try {
      pr.show();
      String productsUrl = Api.apiUrl + Api.endpointProducts;

      var responsedata = await httppost(bearerToken, productsUrl, context);

      var product = jsonDecode(responsedata);
      if (product != null) {
        pr.hide();
      }
      setState(() {
        products.addAll(product);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
        ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductDetail(product: products[index])),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      products[index]['img_url'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      products[index]['prod_name'],
                      style: TextStyle(fontSize: 16.0),
                    ),
                    subtitle: Text(
                      (products[index]["selling_price"]),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        setState(() {
                          items.add(products[index]);
                          sumlist(products[index]["selling_price"]);
                        });
                        setCart(items);
                        ScaffoldMessenger.of(context).showSnackBar(
                          snackBar(
                            'Product added to cart',
                            Colors.green,
                          ),
                        );
                      },
                      child: Icon(Icons.add_shopping_cart),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
