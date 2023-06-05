import 'package:flutter/material.dart';

import '../common.dart';
import '../services/functions.dart';
import 'package:get/get.dart';

class ProductDetail extends StatefulWidget {
  static const routeName = '/productdetail';

  final Map<String, dynamic> product;

  ProductDetail({required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['prod_name']),
      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Image.network(
              widget.product['img_url'],
              fit: BoxFit.fitHeight,
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  widget.product['prod_name'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.product['description'],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '\$${widget.product['selling_price']}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15)),
                        onPressed: () {
                          setState(() {
                            items.add(widget.product);
                            sumlist(widget.product["selling_price"]);
                          });
                          setCart(items);
                          Get.snackbar(
                            widget.product['prod_name'],
                            'added to cart',
                            duration: const Duration(seconds: 3),
                            icon: const Icon(Icons.add_alert),
                            backgroundColor: Colors.amberAccent,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   snackBar(
                          //     'Product added to cart',
                          //     Colors.green,
                          //   ),
                          // );
                        },
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text(
                          "Add to Cart",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
