import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/productdetail';

  final Map<String, dynamic> product;

  ProductDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['prod_name']),
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.network(product['img_url']),
          ),
          SizedBox(height: 16),
          Text(
            product['prod_name'],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            '\$${product['selling_price']}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
