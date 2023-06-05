import 'package:ecommerce/shop/items_page.dart';
import 'package:get/get.dart';
import 'package:ecommerce/shop/product_page.dart';

class CartController extends GetxController {
  var cartItems = <ProductPage>[].obs;

  void addToCart(ProductPage product) {
    cartItems.add(product);
  }
}
