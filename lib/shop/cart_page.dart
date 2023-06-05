import 'dart:convert';

import 'package:ecommerce/shop/CartController.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common.dart';
import '../tabs_screen.dart';
import 'items_page.dart';

class ShoppingCartPage extends StatefulWidget {
  static const routeName = '/cart';
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final CartController _cartController = Get.find();

  var itemsincart = [];
  @override
  void initState() {
    getCart().then((value) {
      setState(() {
        itemsincart = jsonDecode(value);
      });
    });
    super.initState();
  }

  Future getCart() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString('cart');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text("No items in the shopping cart"),
                  )
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Container(
                                child: Row(
                                  children: [
                                    Image.network(
                                      items[index]["img_url"],
                                      height: 150,
                                      width: 250,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                  child: Text(items[index]
                                                      ["prod_name"])),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(items[index]["selling_price"]),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              setState(() {
                                                subtraclist(items[index]
                                                    ["selling_price"]);
                                                items.remove(items[index]);
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Divider(
                              thickness: 1,
                            )
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text("Total: $total"),
          ),
        ],
      ),
    );
  }
}
