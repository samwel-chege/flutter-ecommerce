import 'dart:convert';

import 'package:ecommerce/shop/items_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List items = [];

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
