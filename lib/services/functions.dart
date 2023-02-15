import 'dart:convert';
import 'package:ecommerce/shop/product_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../API/api.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

SnackBar snackBar(message, color) {
  return SnackBar(
      duration: const Duration(seconds: 4),
      backgroundColor: color,
      content: Text(
        message,
        style: const TextStyle(fontSize: 18),
      ));
}

Future httppostsignup(
    String url, Map<String, dynamic> data, BuildContext context) async {
  try {
    var vardata = data;

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(vardata),
    );

    var jsonResponse = json.decode(response.body);

    if (response.statusCode == Api.codeOK) {
      Navigator.of(context).pushReplacementNamed(ProductPage.routeName);
      return jsonResponse;
    } else {
      var res = jsonResponse as Map;

      if (res.keys.elementAt(0) == "name") {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar(jsonResponse["name"][0], Colors.red[500]));
      } else if (res.keys.elementAt(0) == "email") {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar(jsonResponse["email"][0], Colors.red[500]));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBar(jsonResponse["password"][0], Colors.red[500]));
      }

      return jsonResponse;
    }
  } catch (e) {}
}

Future httppost(
    String url, Map<String, dynamic> data, BuildContext context) async {
  try {
    var vardata = data;

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(vardata),
    );

    var jsonResponse = json.decode(response.body);

    if (response.statusCode == Api.codeOK) {
      return jsonResponse;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar(jsonResponse, Colors.red[500]));

      return jsonResponse;
    }
  } catch (e) {}
}
