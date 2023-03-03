// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../common.dart';

import '../API/api.dart';
import '../services/functions.dart';
import '../shop/product_detail.dart';

class ProductCategory extends StatefulWidget {
  final int categoryid;
  final String categoryname;

  const ProductCategory(this.categoryid, this.categoryname, {super.key});

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  // final Cart cart = Cart();
  @override
  void initState() {
    gettoken();

    super.initState();
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
      String productsUrl =
          Api.apiUrl + Api.endpointCategory + widget.categoryid.toString();

      var responsedata = await httppost(bearerToken, productsUrl, context);

      var productsdata = jsonDecode(responsedata);
      if (productsdata != null) {
        pr.hide();
        setState(() {
          products = productsdata;
        });
      } else {
        pr.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarWidget(
            'No data found',
            Colors.red,
          ),
        );
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryname),
      ),
      body: products.isNotEmpty
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          subtitle: Text(
                            (products[index]["selling_price"]),
                            style: const TextStyle(fontSize: 14.0),
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
                            child: const Icon(Icons.add_shopping_cart),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text("No products found for this category"),
            ),
    );
  }
}
