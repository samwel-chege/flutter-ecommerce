import 'package:flutter/material.dart';

import '../common.dart';

class ProductCard extends StatefulWidget {
  final String productName;
  final String productImage;
  final double productPrice;
  final IconData icon;
  final Widget? widget;

  ProductCard(
      {required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.icon,
      required this.widget});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      child: Card(
        child: Column(
          children: <Widget>[
            Image.network(
              widget.productImage,
              height: 100,
              width: 200,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      widget.productName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$" + widget.productPrice.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {
                      widget.icon == Icons.shopping_cart
                          ? setState(() {
                              items.add(widget);
                            })
                          : widget.icon == Icons.delete
                              ? setState(() {
                                  print(widget.productName);
                                  items.remove(widget.widget);
                                  print(items);
                                })
                              : null;
                    },
                    icon: Icon(widget.icon))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
