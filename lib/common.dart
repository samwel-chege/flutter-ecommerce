import 'dart:convert';

import 'package:ecommerce/shop/items_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SnackBar snackBarWidget(message, color) {
  return SnackBar(
      duration: const Duration(seconds: 4),
      backgroundColor: color,
      content: Text(
        message,
        style: const TextStyle(fontSize: 18),
      ));
}

List items = [];

List categories = [
  {"id": 36, "name": "Shoes"},
  {"id": 37, "name": "Clothing"},
  {"id": 38, "name": "Electronics"}
];

double total = 0.00;
double sumlist(price) {
  total += double.parse(price);
  return total;
}

double subtraclist(price) {
  total -= double.parse(price);
  return total;
}

Future setCart(value) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  await pref.setString('cart', jsonEncode(value));
}

Future deleteCart() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  await pref.remove('cart');
}
