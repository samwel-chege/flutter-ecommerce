import 'package:flutter/material.dart';

import '../common.dart';
import 'items_page.dart';

class ShoppingCartPage extends StatefulWidget {
  static const routeName = '/cart';
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  // ShoppingCart _cart = ShoppingCart();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
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
                      return ProductCard(
                        productImage: items[index].productImage,
                        productName: items[index].productName,
                        productPrice: items[index].productPrice,
                        icon: Icons.delete,
                        widget: items[index],
                      );
                      // return ListTile(
                      //   title: Text(items[index].productName),
                      //   trailing: IconButton(
                      //     icon: Icon(Icons.delete),
                      //     onPressed: () {
                      //       setState(() {
                      //         items.remove(items[index]);
                      //       });
                      //     },
                      //   ),
                      // );
                    },
                  ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text("Total: \$0"),
          ),
        ],
      ),
    );
  }
}
